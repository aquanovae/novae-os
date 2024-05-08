{ config, pkgs, ... }: {

  wayland.windowManager.hyprland = {
    enable = true;

    settings = with config.colors; {
      monitor = "eDP-1, prefered, auto, 1";

      exec-once = "swaybg -m fill -i ~/rstore/ricos/home/theme/wallpaper.png";

      input = {
        bind = [
          "super, return, exec, alacritty"
          "super shift, q, killactive"
          "super, t, togglefloating"
          "super, o, exec, bemenu-run"

          "super, h, movefocus, l"
          "super, l, movefocus, r"
          "super, k, movefocus, u"
          "super, j, movefocus, d"

          "super, 1, workspace, 1"
          "super, 2, workspace, 2"
          "super, 3, workspace, 3"
          "super, 4, workspace, 4"
          "super, 5, workspace, 5"
          "super, 6, workspace, 6"
          "super, 7, workspace, 7"
          "super, 8, workspace, 8"
          "super, 9, workspace, 9"
          "super, 0, workspace, 10"

          "super shift, 1, movetoworkspace, 1"
          "super shift, 2, movetoworkspace, 2"
          "super shift, 3, movetoworkspace, 3"
          "super shift, 4, movetoworkspace, 4"
          "super shift, 5, movetoworkspace, 5"
          "super shift, 6, movetoworkspace, 6"
          "super shift, 7, movetoworkspace, 7"
          "super shift, 8, movetoworkspace, 8"
          "super shift, 9, movetoworkspace, 9"
          "super shift, 0, movetoworkspace, 10"

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
        gaps_in = 5;
        gaps_out = 5;

        border_size = 2;

        "col.active_border" = "rgb(${blue}) rgb(${magenta}) 45deg";
        "col.inactive_border" = "rgb(${gray})";

        layout = "dwindle";
      };


      decoration = {
        rounding = 7;

        blur = {
          enabled = true;
          size = 5;
          passes = 1;
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
