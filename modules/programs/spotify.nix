{ config, inputs, lib, pkgs, ... }: {

  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];

  config = lib.mkIf config.novaeOs.programs.spotify.enable {

    programs.spicetify = let
       spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;
      theme = spicePkgs.themes.hazy;
      colorScheme = "Base";
      enabledExtensions = with spicePkgs.extensions; [
        hidePodcasts
      ];
    };
  };
}
