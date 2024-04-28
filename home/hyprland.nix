{ config, pkgs, ... }: {

  wayland.windowManager.hyprland = {
    enable = true;
    #systemd.enable = true;

    settings = with config.colors; {
      monitor = "eDP-1, prefered, auto, 1";

      exec-once = "swaybg -m fill -i ~/rstore/ricos/home/theme/wallpaper.png";


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


      input = {
        kb_layout = "ch";
        kb_variant = "fr_nodeadkeys";
        kb_model = "asus_laptop";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = "yes";
        };
        

        "$mainMod" = "SUPER";
        bind = [
          "$mainMod, return, exec, alacritty"
          "$mainMod shift, q, killactive"
          "$mainMod, t, togglefloating"
          "$mainMod, o, exec, bemenu-run"

          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];
      };
    };
  };
}
