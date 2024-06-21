{
  description = "RicOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = with home-manager; {
      zenblade = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/zenblade/configuration.nix

          nixosModules.home-manager.home-manager {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.rico = import ./home/home.nix;
          }
        ];
      };

      silverlight = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/silverlight/configuration.nix

          nixosModules.home-manager.home-manager {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.rico = import ./home/home.nix;
          }
        ];
      };
    };
  };
}
