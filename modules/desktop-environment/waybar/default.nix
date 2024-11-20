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
        spacing = 7;
        reload_style_on_change = true;

        position = if cfg.mode == "laptop"
          then "top"
          else "bottom";

        margin = if cfg.mode == "laptop"
          then "6px 6px 0px"
          else "0px 6px 6px";

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
