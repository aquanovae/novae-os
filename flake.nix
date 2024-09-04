{
  description = "RicOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations = {

      # Desktop computer
      silverlight = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          username = "rico";
          inherit inputs;
        };

        modules = [
          ./hosts/silverlight
          ./modules
          ./modules/programs/coolercontrol.nix
          ./modules/programs/openrgb.nix
        ];
      };

      # Laptop
      zenblade = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          username = "rico";
          inherit inputs;
        };

        modules = [
          ./hosts/zenblade
          ./modules
          ./modules/core/nvidia.nix
        ];
      };
    };
  };
}
