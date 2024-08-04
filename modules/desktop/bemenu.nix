{ config, lib, pkgs, ... }:

let
  cfg = config.ricos.desktop.menus;
  theme = config.ricos.theme;
in {

  options.ricos.desktop.menus = {
    power = lib.mkOption { type = lib.types.str; };
  };

  config = {
    environment.systemPackages = [ pkgs.bemenu ];

    ricos.desktop.menus = {
      power = ''
        
      '';
    };
  };
}
