{ config, lib, ... }: let

  theme = config.novaeOs.theme;

  # Define bemenu flags used by all menus
  flags = lib.concatStringsSep " " [
    "--single-instance"
    "--ignorecase"
    "--list -1 down"
    "--prefix '>'"
    "--wrap"
    "--center"
    "--width-factor 0.25"
    "--fn 'JetBrainsMono Nerd Font' 13"
    "--border 2"
    "--border-radius 5"
    "--bdr '#${theme.blue}'"
    "--tb '#${theme.blue}'"
    "--tf '#${theme.bg0}'"
    "--fb '#${theme.bg0}'"
    "--ff '#${theme.fg}'"
    "--cb '#${theme.fg}'"
    "--cf '#${theme.bg0}'"
    "--nb '#${theme.bg0}'"
    "--nf '#${theme.fg}'"
    "--hb '#${theme.bg0}'"
    "--hf '#${theme.blue}'"
    "--ab '#${theme.bg0}'"
    "--af '#${theme.fg}'"
  ];

in {

  imports = [
    (import ./powermenu.nix { flags = flags; })
    (import ./quicklaunch.nix { flags = flags; })
  ];
}
