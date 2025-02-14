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
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Experimental has a controller for dram rgb
    # To switch to stable when released
    openrgb-experimental = {
      url = "gitlab:CalcProgrammer1/OpenRGB";
      flake = false;
    };
  };


  outputs = { nixpkgs, ... }@inputs: {

    nixosConfigurations = let

      system = "x86_64-linux";
      extraPkgs = {
        daily-playlist = inputs.daily-playlist.packages.${system}.default;
      };
      specialArgs = { 
        inherit inputs extraPkgs;
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
  };
}
