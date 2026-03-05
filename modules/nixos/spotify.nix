{ inputs, ... }: {

  flake.nixosModules.spotify = { pkgs, ... }: let

    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};

  in {

    imports = [ inputs.spicetify-nix.nixosModules.default ];

    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.hazy;
      colorScheme = "Base";
      enabledExtensions = [ spicePkgs.extensions.hidePodcasts ];
    };
  };
}
