# ------------------------------------------------------------------------------
# Task bar configuration
# ------------------------------------------------------------------------------
{ config, lib, username, ... }:

let
  cfg = config.novaeOs.desktopEnvironment;
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

        position = "top";

        margin = "6px 6px 0px";

        modules-left = [
          "custom/os-icon"
          "hyprland/workspaces"
          "custom/new-window-direction"
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
          "wireplumber"
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
