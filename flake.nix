{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    wrappers.url = "github:Lassulus/wrappers";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spotify-daily = {
      url = "github:aquanovae/spotify-daily";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    openrgb = {
      url = "git+https://gitlab.com/CalcProgrammer1/OpenRGB?rev=0fca93e4544f943d4d7ec8073dba4e47c18ef54b";
      flake = false;
    };
    openrgb-effects-plugin = {
      url = "git+https://gitlab.com/OpenRGBDevelopers/OpenRGBEffectsPlugin?submodules=1&rev=415dc20ef44cbad5546b4987b50764de44a0622e";
      flake = false;
    };
  };

  outputs = { flake-parts, ... }@inputs: (
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [
        ./configurations
        ./modules
        ./wrappers
      ];
    }
  );
}
