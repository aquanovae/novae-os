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

    zen-browser = {
      url = "https://github.com/zen-browser/desktop/releases/download/twilight/zen-x86_64.AppImage";
      flake = false;
    };

    openrgb-experimental = {
      url = "gitlab:CalcProgrammer1/OpenRGB";
      flake = false;
    };
  };


  outputs = { nixpkgs, ... }@inputs: {

    nixosConfigurations = let

      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      extraPkgs = {
        daily-playlist = inputs.daily-playlist.packages.${system}.default;
        zen-browser = pkgs.callPackage ./extra-pkgs/zen-browser.nix { inherit inputs; };
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
