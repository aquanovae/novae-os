{ ... }: {

  flake.nixosModules.lockscreen = { config, ... }: with config; {

    home-manager.users.aquanovae.programs.hyprlock.enable = true;
    home-manager.users.aquanovae.programs.hyprlock.settings = {
      general = {
        hide_cursor = true;
        no_fade_in = true;
      };

      background = [{ 
        monitor = "";
        path = "${../../assets/wallpaper.png}";
        blur_passes = 3;
        blur_size = 5;
      }];

      shape = [{
        # Box around input field
        monitor = "";
        size = "260, 90";
        position = "200, 0";
        halign = "left";
        valign = "center";
        border_size = 2;
        rounding = 5;
        color = "rgb(${theme.bg0})";
        border_color = "rgb(${theme.bg2})";
      }];

      input-field = [{
        monitor = "";
        size = "200, 30";
        position = "220, -10";
        halign = "left";
        valign = "center";
        fade_on_empty = false;
        placeholder_text = "";
        fail_text = "";
        outline_thickness = 2;
        rounding = 5;
        outer_color = "rgb(${theme.blue})";
        inner_color = "rgb(${theme.bg3})";
        fail_color = "rgb(${theme.red})";
        check_color = "rgb(${theme.magenta})";
        font_color = "rgb(${theme.fg})";
        capslock_color = "rgb(${theme.red})";
      }];

      label = [{
        # Time
        monitor = "";
        position = "200, 130";
        halign = "left";
        valign = "center";
        text = "$TIME";
        font_family = "JetBrainsMono Nerd Font Bold";
        font_size = "47";
      }] ++ [{
        # Username
        monitor = "";
        position = "220, 25";
        halign = "left";
        valign = "center";
        text = "$USER";
        font_family = "JetBrainsMono Nerd Font";
        font_size = "11";
      }] ++ [{
        # Battery level
        monitor = "";
        position = "200, 77";
        halign = "left";
        valign = "center";
        font_family = "JetBrainsMono Nerd Font";
        font_size = "11";
        text = ''
          cmd[update:60000] echo "$(cat /sys/class/power_supply/BAT0/capacity)% 󰁹"
        '';
      }];
    };
  };
}
