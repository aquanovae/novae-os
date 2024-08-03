{ ... }: {

  home-manager.users.rico.wayland.windowManager.hyprland.settings.inputs.bind = [
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
  home-manager.users.rico.wayland.windowManager.hyprland.settings.inputs.submap = [
    "resize"
  ];
}
