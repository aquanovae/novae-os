{
  description = "Novae OS config";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    daily-playlist = {
      url = "github:aquanovae/daily-playlist";
      flake = false;
    };

    # Experimental has a controller for dram rgb
    # To switch to stable when released
    openrgb-experimental = {
      url = "gitlab:CalcProgrammer1/OpenRGB";
      flake = false;
    };

    # Encountering compilation error with stable release
    looking-glass-experimental = {
      url = "git+https://github.com/gnif/LookingGlass?submodules=1";
      flake = false;
    };
  };


  outputs = { nixpkgs, self, ... }@inputs: let

    inherit (self) outputs;
    system = "x86_64-linux";

  in {

    nixosConfigurations = let

      specialArgs = { 
        inherit inputs outputs system;
        username = "aquanovae";
      };

    in {

      silverlight = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/silverlight
          ./modules
        ];
      };

      zenblade = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/zenblade
          ./modules
        ];
      };

      minix-server = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/minix-server
          ./modules
        ];
      };

      live-image = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/live-image
          ./modules
        ];
      };
    };


    packages.${system} = let

      pkgs = import nixpkgs { inherit system; };

      packages = [
        "daily-playlist"
      ];

    in nixpkgs.lib.attrsets.genAttrs packages (
      packageName: pkgs.callPackage ./packages/${packageName}.nix { inherit inputs; }
    );
  };
}
