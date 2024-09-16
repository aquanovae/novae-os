{ config, lib, username, ... }:

let
  cfg = config.ricos.desktopEnvironment.waybar;
in {

  imports = [
    ./modules.nix
    ./style.nix
  ];

  config = lib.mkIf config.ricos.desktopEnvironment.enable {
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

        modules-center = lib.mkIf (cfg.modules != "minimal") [
          "custom/playerctl-info"
        ];

        modules-right = lib.optionals (cfg.modules == "desktop") [
          "custom/shutdowntime"
          "disk"
          "memory"
          "cpu"
          "custom/gpu-info"
        ] ++ lib.optionals (cfg.modules == "laptop") [
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
