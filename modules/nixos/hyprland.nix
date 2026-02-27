{ ... }: let

  launchOnce = title: command: /*bash*/ ''
    hyprctl -j clients | jq ".[].title" | grep "${title}" || ${command}
  '';

in {

  flake.nixosModules.hyprland = { config, pkgs, ... }: with config; {

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      brightnessctl
      pamixer
      playerctl
      swaybg
    ];

    home-manager.users.aquanovae.wayland.windowManager.hyprland.enable = true;
    home-manager.users.aquanovae.wayland.windowManager.hyprland.extraConfig = /*hyprlang*/ ''
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
      bind = super shift, F, fullscreen, 0
      bind = super, T, togglefloating, active

      # Manage groups
      bind = super, G, togglegroup
      bind = super, N, changegroupactive, f
      bind = super shift, N, changegroupactive, b
      bind = super, B, movegroupwindow, f
      bind = super shift, B, movegroupwindow, b

      # Open programs
      bind = super, Return, exec, alacritty
      bind = super, O, exec, alacritty -T launcher -e otter-launcher &

      # Special workspace to edit config
      bind = super, R, togglespecialworkspace, config
      bind = super, R, exec, ${launchOnce "config" /*bash*/ ''
        alacritty -T config --working-directory /home/aquanovae/novae-os -e vim &
      ''}

      # Special workspace for file explorer
      bind = super, E, togglespecialworkspace, ranger
      bind = super, E, exec, ${launchOnce "ranger" /*bash*/ ''
        alacritty -T ranger -e ranger &
      ''}

      # Close program
      bind = super shift, Q, killactive

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

      # Lock and suspend on lid close
      bind = , switch:on:Lid Switch, exec, hyprlock & sleep 1 && systemctl suspend
    '';

    home-manager.users.aquanovae.wayland.windowManager.hyprland.settings = {
      monitor = [
        ", prefered, auto, 1"
        "DP-1, 2560x1440@165, 0x0, 1"
        "DP-2, 2560x1440@165, 2560x0, 1"
      ];

      workspace = [
        "monitor:DP-1, 1"
        "monitor:DP-1, 3"
        "monitor:DP-1, 5"
        "monitor:DP-1, 7"
        "monitor:DP-1, 9"

        "monitor:DP-2, 2"
        "monitor:DP-2, 4"
        "monitor:DP-2, 6"
        "monitor:DP-2, 8"
        "monitor:DP-2, 10"
      ];

      windowrule = [
        "match:title launcher, float on"
        "match:title launcher, size monitor_w*0.25 300"
        "match:title config, workspace config"
        "match:title ranger, workspace ranger"
        "match:title ranger, float on"
        "match:title ranger, size 75% 75%"
      ];

      exec-once = [
        "swaybg -m fill -i ${../../assets/wallpaper.png}"
        "waybar &"
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

      decoration = {
        rounding = 7;
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
        movefocus_cycles_fullscreen = true;
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

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      group = {
        "col.border_active" = "rgb(${theme.blue}) rgb(${theme.magenta}) 45deg";
        "col.border_inactive" = "rgb(${theme.bg3})";
      };
      group.groupbar = {
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
  };
}
