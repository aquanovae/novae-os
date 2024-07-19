{ config, lib, pkgs, ... }:

let
  cfg = config.ricos.programs.base;
in {

  options.ricos.programs.base = {
    enable = lib.mkEnableOption "enable base programs";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      alacritty
      firefox
      spotify
    ];
  };
}
