{
  description = "RicOS config";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
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

      specialArgs = { inherit inputs outputs system; };
      modules = [
        ./hosts
        ./modules
      ];

    in {
      silverlight = nixpkgs.lib.nixosSystem {
        inherit system modules;
        specialArgs = specialArgs // {
          hostname = "silverlight";
          username = "rico";
        };
      };

      zenblade = nixpkgs.lib.nixosSystem {
        inherit system modules;
        specialArgs = specialArgs // {
          hostname = "zenblade";
          username = "rico";
        };
      };

      minix-server = nixpkgs.lib.nixosSystem {
        inherit system modules;
        specialArgs = specialArgs // {
          hostname = "minix-server";
          username = "nix-host";
        };
      };

      live-image = nixpkgs.lib.nixosSystem {
        inherit system modules;
        specialArgs = specialArgs // {
          hostname = "live-image";
          username = "nixos";
        };
      };
    };

    packages.${system} = let

      pkgs = import nixpkgs { inherit system; };
      packages = [
      ];

    in nixpkgs.lib.attrsets.genAttrs packages (
      packageName: pkgs.callPackage ./packages/${packageName}.nix { inherit inputs; }
    );
  };
}
