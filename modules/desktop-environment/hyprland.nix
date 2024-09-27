{ config, lib, username, ... }:

let
  theme = config.ricos.theme;

  wallpaper = "/home/rico/.config/hypr/wallpaper.png";
in {

  config = lib.mkIf config.ricos.desktopEnvironment.enable {
    home-manager.users.${username}.wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        monitor = [
          "eDP-1, prefered, auto, 1"
          "DP-1, 2560x1440@165, 0x0, 1"
          "DP-2, 2560x1440@165, 2560x0, 1"
        ];

        exec-once = [
          "swaybg -m fill -i ${wallpaper}"
        ];

        general = {
          gaps_in = 3;
          gaps_out = 6;

          border_size = 2;

          "col.active_border" = "rgb(${theme.blue}) rgb(${theme.magenta}) 45deg";
          "col.inactive_border" = "rgb(${theme.gray})";

          layout = "dwindle";
        };

        dwindle = {
          pseudotile = true;
          force_split = 2;
        };

        input = {
          kb_layout = "ch";
          kb_variant = "fr_nodeadkeys";
          kb_model = "asus_laptop";
          numlock_by_default = true;

          follow_mouse = 1;

          touchpad = {
            natural_scroll = true;
          };
        };

        binds = {
          workspace_back_and_forth = true;
        };

        decoration = {
          rounding = 7;

        blur = {
          enabled = true;
          size = 3;
          passes = 3;
        };
      };

        animations = {
          enabled = true;

          animation = [
            "global, 1, 3, default"
            "windows, 1, 3, default, popin"
            "workspaces, 1, 3, default, slide"
          ];
        };

        cursor = {
          inactive_timeout = 17;
        };

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };
      };
    };
  };
}
