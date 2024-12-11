{ inputs, pkgs, ... } : {

  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];

  programs.spicetify = let

     spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {

    enable = true;

    theme = spicePkgs.themes.lucid;
    colorScheme = "dark";

    enabledExtensions = with spicePkgs.extensions; [
      hidePodcasts
    ];
  };
}
