{ config, pkgs, ... }: {

  wayland.windowManager.hyprland = {
    enable = true;

    settings = with config.colors; {
      monitor = "eDP-1, prefered, auto, 1";

      exec-once = [
        "swaybg -m fill -i ~/rstore/ricos/home/theme/wallpaper.png"
        "hyprctl dispatch renameworkspace 1 terminal"
      ];

      workspace = [
        "name:terminal, default:true"
        "name:browser, on-created-empty:firefox"
      ];

      input = {
        bind = [
          "super, t, workspace, name:terminal"
          "super, b, workspace, name:browser"

          "super, return, exec, alacritty"

          "super, o, exec, bemenu-run"
          "super shift, q, killactive"

          "super, m, workspace, +0"

          "super, h, movefocus, l"
          "super, l, movefocus, r"
          "super, k, movefocus, u"
          "super, j, movefocus, d"

          "alt, h, movewindow, l"
          "alt, l, movewindow, r"
          "alt, k, movewindow, u"
          "alt, j, movewindow, d"

          "super, s, togglespecialworkspace, magic"
          "super shift, s, movetoworkspace, special:magic"
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


      binds = {
        workspace_back_and_forth = true;
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
