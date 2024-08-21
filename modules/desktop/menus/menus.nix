{ config, lib, pkgs, ... }:

let
  theme = config.ricos.theme;
in {

  imports = [
    ./powermenu.nix
    ./quicklaunch.nix
  ];

  options.ricos.desktop.menus = {
    bemenuFlags = lib.mkOption { type = lib.types.str; };
  };

  config = {
    environment.systemPackages = [ pkgs.bemenu ];

    ricos.desktop.menus = 
    let
      flags = [
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

      bemenuFlags = "${lib.strings.concatStringsSep " " flags}";
    };
  };
}
