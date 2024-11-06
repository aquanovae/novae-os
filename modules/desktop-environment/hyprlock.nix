# ------------------------------------------------------------------------------
# Lock screen configuration
# ------------------------------------------------------------------------------
{ config, lib, username, ... }:

let
  theme = config.ricos.theme;
in {

  config = lib.mkIf config.ricos.desktopEnvironment.enable {
    home-manager.users.${username}.programs.hyprlock = {
      enable = true;

      settings = {
        general = {
          hide_cursor = true;
          no_fade_in = true;
        };

        background = [
          # Set blured wallpaper as background
          { monitor = "";
            path = "/home/rico/.config/hypr/wallpaper.png";
            blur_passes = 3;
            blur_size = 5;
          }
        ];

        shape = [
          # Box around usernam and input field
          { monitor = "";
            size = "260, 90";
            position = "200, 0";
            halign = "left";
            valign = "center";

            border_size = 2;
            rounding = 5;
            color = "rgb(${theme.bg0})";
            border_color = "rgb(${theme.bg2})";
          }
        ];

        label = [
          # Disply username
          { monitor = "";
            position = "220, 23";
            halign = "left";
            valign = "center";

            text = "$USER";
            font_family = "JetBrainsMono Nerd Font";
            font_size = "13";
          }

          # Display time
          { monitor = "";
            position = "200, 130";
            halign = "left";
            valign = "center";

            text = "$TIME";
            font_family = "JetBrainsMono Nerd Font Bold";
            font_size = "47";
          }
        ];

        input-field = [
          # Password input field
          { monitor = "";
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
          }
        ];
      };
    };
  };
}