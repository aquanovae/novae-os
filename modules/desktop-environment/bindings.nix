{ config, lib, username, ... }: {

  config = lib.mkIf config.ricos.desktopEnvironment.enable {
    home-manager.users.${username}.wayland.windowManager.hyprland.extraConfig = /*hyprlang*/ ''
      # Focus workspace
      bind = super, 1, workspace, 1
      bind = super, 2, workspace, 2
      bind = super, 3, workspace, 3
      bind = super, 4, workspace, 4
      bind = super, 5, workspace, 5
      bind = super, 6, workspace, 6
      bind = super, 7, workspace, 7
      bind = super, 8, workspace, 8
      bind = super, 9, workspace, 9
      bind = super, 0, workspace, 10

      # Swap focused workspace between monitors
      bind = super, N, swapactiveworkspaces, 0 1

      # Move focus
      bind = super, H, movefocus, l
      bind = super, L, movefocus, r
      bind = super, K, movefocus, u
      bind = super, J, movefocus, d

      # Move window
      bind = super shift, H, movewindow, l
      bind = super shift, L, movewindow, r
      bind = super shift, K, movewindow, u
      bind = super shift, J, movewindow, d

      # Send window to workspace
      bind = super shift, 1, movetoworkspacesilent, 1
      bind = super shift, 2, movetoworkspacesilent, 2
      bind = super shift, 3, movetoworkspacesilent, 3
      bind = super shift, 4, movetoworkspacesilent, 4
      bind = super shift, 5, movetoworkspacesilent, 5
      bind = super shift, 6, movetoworkspacesilent, 6
      bind = super shift, 7, movetoworkspacesilent, 7
      bind = super shift, 8, movetoworkspacesilent, 8
      bind = super shift, 9, movetoworkspacesilent, 9
      bind = super shift, 0, movetoworkspacesilent, 10

      # Modify window state
      bind = super, F, fullscreen, 1
      bind = super shift, F, togglefloating, active

      # Open programs
      bind = super, Return, exec, alacritty
      bindr = super, Super_L, exec, quicklaunch

      # Preselect split direction
      bind = alt, J, layoutmsg, preselect l
      bind = alt, K, layoutmsg, preselect r

      # Close program
      bind = super shift, Q, killactive

      # Open powermenu
      bind = super, Escape, exec, powermenu

      # Lock screen
      bind = super shift, Escape, exec, hyprlock

      # Volume control
      bind = , XF86AudioMute, exec, pamixer -t
      binde = , XF86AudioRaiseVolume, exec, pamixer -i 5
      binde = , XF86AudioLowerVolume, exec, pamixer -d 5

      # Dedicated playback control keys
      bind = , XF86AudioPlay, exec, playerctl play-pause
      bind = , XF86AudioNext, exec, playerctl next
      bind = , XF86AudioPrev, exec, playerctl previous

      # Playback control without dedicated keys
      bind = control, F1, exec, playerctl play-pause
      bind = control, F2, exec, playerctl previous
      bind = control, F3, exec, playerctl next

      # Monitor brightness control
      binde = , XF86MonBrightnessUp, exec, brightnessctl set 5%+
      binde = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
    '';
  };
}
