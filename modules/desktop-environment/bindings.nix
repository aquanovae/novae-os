{ config, lib, username, ... }: {

  config = lib.mkIf config.ricos.desktopEnvironment.enable {
    home-manager.users.${username}.wayland.windowManager.hyprland.extraConfig = /*hyprlang*/ ''
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

      bind = super, H, movefocus, l
      bind = super, L, movefocus, r
      bind = super, K, movefocus, u
      bind = super, J, movefocus, d

      bind = super, N, swapactiveworkspaces, 0 1

      bind = super, Return, exec, alacritty

      bindr = super, Super_L, exec, quicklaunch

      bind = super shift, Q, killactive
      bind = super, Escape, exec, powermenu

      bind = super, M, submap, move
      submap = move
      bind = , Escape, submap, reset
      bind = , catchall, exec,

      bind = , H, movefocus, l
      bind = , L, movefocus, r
      bind = , K, movefocus, u
      bind = , J, movefocus, d
      bind = shift, H, movewindow, l
      bind = shift, L, movewindow, r
      bind = shift, K, movewindow, u
      bind = shift, J, movewindow, d

      bind = , 1, workspace, 1
      bind = , 2, workspace, 2
      bind = , 3, workspace, 3
      bind = , 4, workspace, 4
      bind = , 5, workspace, 5
      bind = , 6, workspace, 6
      bind = , 7, workspace, 7
      bind = , 8, workspace, 8
      bind = , 9, workspace, 9
      bind = , 0, workspace, 10
      bind = shift, 1, movetoworkspacesilent, 1
      bind = shift, 2, movetoworkspacesilent, 2
      bind = shift, 3, movetoworkspacesilent, 3
      bind = shift, 4, movetoworkspacesilent, 4
      bind = shift, 5, movetoworkspacesilent, 5
      bind = shift, 6, movetoworkspacesilent, 6
      bind = shift, 7, movetoworkspacesilent, 7
      bind = shift, 8, movetoworkspacesilent, 8
      bind = shift, 9, movetoworkspacesilent, 9
      bind = shift, 0, movetoworkspacesilent, 10

      bind = , N, swapactiveworkspaces, 0 1
      submap = reset

      bind = , XF86AudioMute, exec, pamixer -t
      binde = , XF86AudioRaiseVolume, exec, pamixer -i 5
      binde = , XF86AudioLowerVolume, exec, pamixer -d 5

      bind = , XF86AudioPlay, exec, playerctl play-pause
      bind = , XF86AudioNext, exec, playerctl next
      bind = , XF86AudioPrev, exec, playerctl previous

      bind = alt, XF86AudioMute, exec, playerctl play-pause
      bind = alt, XF86AudioRaiseVolume, exec, playerctl next
      bind = alt, XF86AudioLowerVolume, exec, playerctl previous

      binde = , XF86MonBrightnessUp, exec, brightnessctl set 5%+
      binde = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
    '';
  };
}
