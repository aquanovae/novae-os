{ config, lib, username, ... }: let

  cfg = config.novaeOs.desktopEnvironment;
  theme = config.novaeOs.theme;
  wallpaper = "/home/${username}/.config/hypr/wallpaper.png";

in {

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        monitor = [
          ", prefered, auto, 1"
        ] ++ lib.optionals (cfg.mode == "desktop") [
          "DP-1, 2560x1440@165, 0x0, 1"
          "DP-2, 2560x1440@165, 2560x0, 1"
        ];

        workspace = lib.optionals (cfg.mode == "desktop") [
          "1, monitor:DP-1"
          "3, monitor:DP-1"
          "5, monitor:DP-1"
          "7, monitor:DP-1"
          "9, monitor:DP-1"

          "2, monitor:DP-2"
          "4, monitor:DP-2"
          "6, monitor:DP-2"
          "8, monitor:DP-2"
          "10, monitor:DP-2"
        ];

        windowrulev2 = [
          "workspace config, title:(config)"
          "workspace ranger, title:(ranger)"
          "float, title:(ranger)"
          "size 75% 75%, title:(ranger)"
        ];

        exec-once = [
          "swaybg -m fill -i ${wallpaper}"
          "waybar &"
          "spotify-manager track-info -d &"
        ];

        general = {
          layout = "dwindle";
          gaps_in = 3;
          gaps_out = 3;
          border_size = 1;
          "col.active_border" = "rgb(${theme.blue}) rgb(${theme.magenta}) 45deg";
          "col.inactive_border" = "rgb(${theme.bg3})";
        };

        dwindle = {
          pseudotile = true;
          force_split = 2;
        };

        group = {
          "col.border_active" = "rgb(${theme.blue}) rgb(${theme.magenta}) 45deg";
          "col.border_inactive" = "rgb(${theme.bg3})";
          groupbar = {
            font_family = "JetBrainsMono Nerd Font";
            font_size = 13;
            font_weight_active = "bold";
            height = 19;
            indicator_height = 0;
            gaps_in = 3;
            gaps_out = 3;
            keep_upper_gap = false;
            gradients = true;
            gradient_rounding = 5;
            gradient_round_only_edges = false;
            text_color = "rgb(${theme.bg0})";
            text_color_inactive = "rgb(${theme.fg})";
            "col.active" = "rgb(${theme.blue})";
            "col.inactive" = "rgb(${theme.bg0})";
          };
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

        binds = {
          hide_special_on_workspace_change = true;
        };

        input = {
          kb_layout = "ch";
          kb_variant = "fr_nodeadkeys";
          kb_model = "asus_laptop";
          numlock_by_default = true;
          follow_mouse = 1;
          touchpad.natural_scroll = true;
        };

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };
      };
    };
  };
}
