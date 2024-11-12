# ------------------------------------------------------------------------------
# Task bar configuration
# ------------------------------------------------------------------------------
{ config, lib, username, ... }:

let
  cfg = config.ricos.desktopEnvironment;
in {

  imports = [
    ./modules.nix
    ./style.nix
  ];

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.programs.waybar = {
      enable = true;
      systemd.enable = true;

      settings.bar = {
        layer = "top";
        position = "bottom";
        margin = "0px 6px 6px";
        spacing = 7;
        reload_style_on_change = true;

        modules-left = [
          "custom/os-icon"
          "hyprland/workspaces"
          "hyprland/submap"
        ];

        modules-center = lib.mkIf (cfg.mode != "minimal") [
          "custom/playerctl-info"
        ];

        modules-right = lib.optionals (cfg.mode == "desktop") [
          "custom/shutdowntime"
          "disk"
          "memory"
          "cpu"
          "custom/gpu-info"

        ] ++ lib.optionals (cfg.mode == "laptop") [
          "custom/shutdowntime"
          "volume"
          "disk"
          "memory"
          "cpu"
          "battery"

        ] ++ [
          "clock"
        ];
      };
    };
  };
}
