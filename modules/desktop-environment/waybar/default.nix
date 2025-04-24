{ config, lib, username, ... }: let

  cfg = config.novaeOs.desktopEnvironment;

in {

  imports = [
    ./modules.nix
    ./style.nix
  ];

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.programs.waybar = {
      enable = true;

      settings.bar = {
        layer = "top";
        position = "top";
        margin = "3px 3px 0px";
        spacing = 7;
        reload_style_on_change = true;

        modules-left = [
          "custom/os-icon"
          "hyprland/workspaces"
          "custom/new-window-direction"
        ];

        modules-center = lib.mkIf (cfg.mode != "minimal") [
          "custom/spotify-info"
        ];

        modules-right = [
          "custom/shutdowntime"
        ] ++ lib.optionals (cfg.mode == "laptop") [
          "wireplumber"
        ] ++ [
          "disk"
          "memory"
          "cpu"
        ] ++ lib.optionals (cfg.mode == "desktop") [
          "custom/gpu-info"
        ] ++ lib.optionals (cfg.mode == "laptop") [
          "battery"
        ] ++ [
          "clock"
        ];
      };
    };
  };
}
