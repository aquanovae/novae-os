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

    spotify-manager = {
      url = "github:aquanovae/spotify-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "https://github.com/zen-browser/desktop/releases/download/twilight/zen-x86_64.AppImage";
      flake = false;
    };

    openrgb = {
      url = "gitlab:CalcProgrammer1/OpenRGB";
      flake = false;
    };

    openrgb-effects-plugin = {
      url = "git+https://gitlab.com/OpenRGBDevelopers/OpenRGBEffectsPlugin?submodules=1";
      flake = false;
    };

    moon-fly = {
      url = "github:bluz71/vim-moonfly-colors";
      flake = false;
    };

    looking-glass = {
      url = "github:gnif/LookingGlass";
      flake = false;
    };
  };


  outputs = { nixpkgs, ... }@inputs: {

    nixosConfigurations = let

      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      extraPkgs = {
        spotify-manager = inputs.spotify-manager.packages.${system}.default;
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

      minix = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/minix
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
