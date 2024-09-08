{
  description = "RicOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ricos.url = "github:RicoProductions/ricos";

    openrgb-experimental = {
      url = "gitlab:CalcProgrammer1/OpenRGB";
      flake = false;
    };
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations = let
      base = {
        specialArgs = {
          username = "rico";
          de-setup = "desktop";
          inherit inputs;
        };
        modules = [
          ./hosts
          ./modules
        ];
      };
    in {

      silverlight = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = base.specialArgs // {
          hostname = "silverlight";
        };
        modules = base.modules ++ [
          ./modules/programs/desktop.nix
        ];
      };

      zenblade = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = base.specialArgs // {
          hostname = "zenblade";
          de-setup = "laptop";
        };
        modules = base.modules ++ [
          ./modules/core/nvidia.nix
          ./modules/programs/laptop.nix
        ];
      };

      live-image = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = base.specialArgs // {
          hostname = "live-image";
          username = "nixos";
          de-setup = "minimal";
        };
        modules = base.modules;
      };
    };
  };
}
