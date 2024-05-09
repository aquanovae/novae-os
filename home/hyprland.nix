{ config, pkgs, ... }: {

  wayland.windowManager.hyprland = {
    enable = true;

    settings = with config.colors; {
      monitor = "eDP-1, prefered, auto, 1";

      exec-once = [
        "swaybg -m fill -i ~/rstore/ricos/home/theme/wallpaper.png"
        "hyprctl dispatch workspace name:terminal"
      ];

      workspace = [
        "name:terminal, default:true, on-created-empty:alacritty"
        "name:browser, on-created-empty:firefox"
      ];

      input = {
        bind = [
          "super, return, exec, alacritty"
          "super shift, q, killactive"
          "super, o, exec, bemenu-run"

          "super, h, movefocus, l"
          "super, l, movefocus, r"
          "super, k, movefocus, u"
          "super, j, movefocus, d"

          "super, t, workspace, name:terminal"
          "super, b, workspace, name:browser"

          "super, S, togglespecialworkspace, magic"
          "super shift, S, movetoworkspace, special:magic"

          "super, mouse_down, workspace, e+1"
          "super, mouse_up, workspace, e-1"
        ];

        kb_layout = "ch";
        kb_variant = "fr_nodeadkeys";
        kb_model = "asus_laptop";
        numlock_by_default = true;

        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
        };
      };


      general = {
        gaps_in = 3;
        gaps_out = 6;

        border_size = 2;

        "col.active_border" = "rgb(${blue}) rgb(${magenta}) 45deg";
        "col.inactive_border" = "rgb(${gray})";

        layout = "dwindle";
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


      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };
    };
  };
}
