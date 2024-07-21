{ config, lib, pkgs, ... }:

let
  cfg = config.ricos.programs.gaming;
in {

  options.ricos.programs.gaming = {
    enable = lib.mkEnableOption "enable gaming programs";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lutris
      prismlauncher
    ];

    programs.steam.enable = true;
  };
}
