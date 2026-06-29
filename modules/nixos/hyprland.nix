{ ... }: {

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

    home-manager.users.aquanovae.wayland.windowManager.hyprland.configType = "lua";
    home-manager.users.aquanovae.wayland.windowManager.hyprland.extraConfig = /*lua*/ ''

      -- Focus workspace
      hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
      hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
      hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
      hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
      hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
      hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
      hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
      hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))
      hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 9 }))
      hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))

      -- Move focus
      hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }))
      hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))
      hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
      hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" }))

      -- Move window
      hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
      hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
      hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
      hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "r" }))

      -- Send window to workspace
      hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1, follow = false }))
      hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2, follow = false }))
      hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3, follow = false }))
      hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4, follow = false }))
      hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5, follow = false }))
      hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6, follow = false }))
      hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7, follow = false }))
      hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8, follow = false }))
      hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 9, follow = false }))
      hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10, follow = false }))

      -- Modify window state
      hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
      hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
      hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }))

      -- Manage groups
      --bind = super, G, togglegroup
      --bind = super, N, changegroupactive, f
      --bind = super shift, N, changegroupactive, b
      --bind = super, B, movegroupwindow, f
      --bind = super shift, B, movegroupwindow, b

      function launch_once(name, command)
        local windows = hl.get_windows()
        for _,window in pairs(windows) do
          if (window.title == name) then
            return
          end
        end
        hl.dispatch(hl.dsp.exec_cmd(command))
      end

      -- Open programs
      hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("alacritty"))
      hl.bind("SUPER + O", function()
        launch_once("launcher", "alacritty -T launcher -e otter-launcher")
      end)

      -- Special workspaces
      hl.bind("SUPER + R", function()
        launch_once("config", "alacritty -T config --working-directory ~/novae-os -e vim")
        hl.dispatch(hl.dsp.workspace.toggle_special("config"))
      end)
      hl.bind("SUPER + E", function()
        launch_once("ranger", "alacritty -T ranger -e ranger")
        hl.dispatch(hl.dsp.workspace.toggle_special("ranger"))
      end)

      -- Close window
      hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close())

      -- Lock session
      hl.bind("SUPER + SHIFT + ESCAPE", hl.dsp.exec_cmd("hyprlock"))

      -- Suspend
      hl.bind("SUPER + CONTROL + ESCAPE", hl.dsp.exec_cmd("systemctl suspend &"))

      -- Volume control
      hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"))
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { repeating = true })
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { repeating = true })

      -- Playback control
      hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
      hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
      hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
      hl.bind("CONTROL + F1", hl.dsp.exec_cmd("playerctl play-pause"))
      hl.bind("CONTROL + F2", hl.dsp.exec_cmd("playerctl next"))
      hl.bind("CONTROL + F3", hl.dsp.exec_cmd("playerctl previous"))

      -- Monitor brightness control
      hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { repeating = true })
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })

      -- Autostart
      hl.on("hyprland.start", function()
        hl.exec_cmd("swaybg -m fill -i ${../../assets/wallpaper.png}")
        hl.exec_cmd("waybar")
      end)
    '';

    home-manager.users.aquanovae.wayland.windowManager.hyprland.settings.config = {

      general = {
        border_size = 1;
        gaps_in = 3;
        gaps_out = 3;
        "col.inactive_border" = { colors = [ "rgb(${theme.bg3})" ]; };
        "col.active_border" = { colors = [ "rgb(${theme.blue})" "rgb(${theme.magenta})" ]; angle = 45; };
        layout = "dwindle";
      };

      decoration = {
        rounding = 7;
        blur.enabled = false;
      };

      animations = [
        { leaf = "global";    enabled = true; speed = 1; bezier = "default"; }
        { leaf = "windows";   enabled = true; speed = 1; bezier = "default"; style = "popin 80%"; }
        { leaf = "workspace"; enabled = true; speed = 1; bezier = "default"; style = "slide 80%"; }
      ];

      input = {
        kb_layout = "ch";
        kb_variant = "fr_nodeadkeys";
        numlock_by_default = true;
        follow_mouse = 1;
      };

      group = {
        "col.border_inactive" = { colors = [ "rgb(${theme.bg3})" ]; };
        "col.border_active" = { colors = [ "rgb(${theme.blue})" "rgb(${theme.magenta})"]; angle = 45; };
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

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
      };

      binds = {
        hide_special_on_workspace_change = true;
        movefocus_cycles_fullscreen = true;
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      dwindle = {
        force_split = 2;
      };
    };

    home-manager.users.aquanovae.wayland.windowManager.hyprland.settings.window_rule = [
      { match = { title = "launcher"; }; float = true; size = [ "(monitor_w*0.25)" "140" ]; }
      { match = { title = "config"; }; workspace = "special:config"; }
      { match = { title = "ranger"; }; workspace = "special:ranger"; float = true; size = [ "(monitor_w*0.75)" "(monitor_h*0.75)" ]; }
      { match = { class = "steam"; }; workspace = 5; }
    ];

  };

  flake.nixosModules.hyprlandSilverlight = { ... }: {

    home-manager.users.aquanovae.wayland.windowManager.hyprland.settings.monitor = [
      { output = "DP-1"; mode = "2560x1440@165"; position = "0x0";    scale = 1; }
      { output = "DP-1"; mode = "2560x1440@165"; position = "2560x0"; scale = 1; }
    ];

    home-manager.users.aquanovae.wayland.windowManager.hyprland.settings.config = {
      input.kb_model = "logitech_base";
    };

    home-manager.users.aquanovae.wayland.windowManager.hyprland.settings.workspace_rule = [
      { workspace = 1; monitor = "DP-1"; }
      { workspace = 3; monitor = "DP-1"; }
      { workspace = 5; monitor = "DP-1"; }
      { workspace = 7; monitor = "DP-1"; }
      { workspace = 9; monitor = "DP-1"; }

      { workspace = 2; monitor = "DP-2"; }
      { workspace = 4; monitor = "DP-2"; }
      { workspace = 6; monitor = "DP-2"; }
      { workspace = 8; monitor = "DP-2"; }
      { workspace = 10; monitor = "DP-2"; }
    ];

    home-manager.users.aquanovae.wayland.windowManager.hyprland.extraConfig = /*lua*/ ''
      hl.on("hyprland.start", function()
        hl.exec_cmd("zen",     { workspace = 2 })
        hl.exec_cmd("spotify", { workspace = 4 })
      end)
    '';
  };

  flake.nixosModules.hyprlandZenblade = { ... }: {

    home-manager.users.aquanovae.wayland.windowManager.hyprland.settings.monitor = [
      { output = ""; mode = "preferred"; position = "auto"; scale = 1; }
    ];

    home-manager.users.aquanovae.wayland.windowManager.hyprland.settings.config = {
      input = {
        kb_model = "asus_laptop";
        touchpad.natural_scroll = true;
      };
    };

    home-manager.users.aquanovae.wayland.windowManager.hyprland.extraConfig = /*lua*/ ''
      -- Lid close
      hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprlock & sleep 1 && systemctl suspend"))
    '';
  };
}
