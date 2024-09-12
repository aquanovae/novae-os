{ hostname, lib, username, ... }:

let
  modules-left = [
    "custom/os-icon"
    "hyprland/workspaces"
    "hyprland/submap"
  ];

  modules-center = lib.optionals (
    (hostname == "silverlight") || 
    (hostname == "zenblade")
  ) [
    "custom/playerctl-info"
  ];

  modules-right = lib.optionals (hostname == "silverlight") [
    "custom/shutdowntime"
    "disk"
    "memory"
    "cpu"
    "custom/gpu-info"
    "clock"

  ] ++ lib.optionals (hostname == "zenblade") [
    "custom/shutdowntime"
    "volume"
    "disk"
    "memory"
    "cpu"
    "battery"
    "clock"

  ] ++ lib.optionals (hostname == "live-iso") [
    "clock"
  ];
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
      reload_style_on_change = true;

      modules-left = modules-left;
      modules-center = modules-center;
      modules-right = modules-right;
    };
  };
}
