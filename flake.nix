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

      silverlight = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/silverlight/configuration.nix
          ./modules/ricos.nix
        ];
      };

      zenblade = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/zenblade/configuration.nix
          ./modules/ricos.nix
        ];
      };
    };
  };
}
