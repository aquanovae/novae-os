{ config, lib, ... }:

let
  cfg = config.ricos.desktop.bar;
  theme = config.ricos.theme;
in {

  imports = [
    ./modules.nix
    ./style.nix
  ];

  options.ricos.desktop.bar = {
    volume.enable = lib.mkEnableOption "enable volume";
    battery.enable = lib.mkEnableOption "enable battery";
  };

  config = {
    programs.waybar.enable = true;

    home-manager.users.rico.programs.waybar = {
      enable = true;
      systemd.enable = true;

      settings.bar = {
        layer = "top";
        position = "bottom";
        margin = "0px 6px 6px";
        spacing = 7;

        modules-left = [
          "custom/os-icon"
          "hyprland/workspaces"
          "hyprland/submap"
        ];

        modules-right = [
          "custom/shutdowntime" ] ++
          (if cfg.volume.enable then [ "pulseaudio" ] else []) ++ [
          "disk"
          "memory"
          "cpu"
          "custom/gpu-info" ] ++
          (if cfg.battery.enable then [ "battery" ] else []) ++ [
          "clock"
        ];

        reload_style_on_change = true;
      };
    };
  };
}
