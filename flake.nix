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

    openrgb = {
      url = "git+https://gitlab.com/CalcProgrammer1/OpenRGB?rev=acca2baa57217e26e4fc2e08477142cd67759b08";
      flake = false;
    };

    openrgb-effects-plugin = {
      url = "git+https://gitlab.com/OpenRGBDevelopers/OpenRGBEffectsPlugin?submodules=1&rev=4a345b46bae83180df529a83c3b4077a6c084eda";
      flake = false;
    };

    moon-fly = {
      url = "github:bluz71/vim-moonfly-colors";
      flake = false;
    };

    winboat = {
      url = "github:TibixDev/winboat";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { nixpkgs, ... }@inputs: {

    nixosConfigurations = let

      system = "x86_64-linux";
      extraPkgs = {
        spotify-manager = inputs.spotify-manager.packages.${system}.default;
        winboat = inputs.winboat.packages.${system}.winboat;
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
