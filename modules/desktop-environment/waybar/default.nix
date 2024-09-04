{ config, username, ... }:

let
  cfg = config.ricos.waybar;
in {

  imports = [
    ./modules.nix
    ./style.nix
  ];

  home-manager.users.${username}.programs.waybar = {
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

      modules-center = [
        "custom/playerctl-info"
      ];

      modules-right = [
        "custom/shutdowntime" ] ++
        (if cfg.enableVolume then [ "pulseaudio" ] else []) ++ [
        "disk"
        "memory"
        "cpu"
        "custom/gpu-info" ] ++
        (if cfg.enableBattery then [ "battery" ] else []) ++ [
        "clock"
      ];

      reload_style_on_change = true;
    };
  };
}
