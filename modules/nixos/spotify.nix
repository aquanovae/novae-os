{ inputs, ... }: {

  flake.nixosModules.spotify = { pkgs, ... }: {

    imports = [ inputs.spicetify-nix.nixosModules.default ];

    programs.spicetify = with inputs.spicetify-nix.legacyPackages.${pkgs.system}; {
      enable = true;
      theme = themes.hazy;
      colorScheme = "Base";
      enabledExtensions = [ extensions.hidePodcasts ];
    };
  };
}
