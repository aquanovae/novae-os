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
        };

        background = [{
          monitor = "";
          path = "/home/rico/.config/hypr/wallpaper.png";
          blur_passes = 3;
          blur_size = 5;
        }];

        input-field = [{
          monitor = "";
          position = "300, 0";
          halign = "left";
          valign = "center";
          size = "200, 30";
          outline_thickness = 2;
          rounding = 5;
          outer_color = "rgb(${theme.blue})";
          inner_color = "rgb(${theme.bg0})";
          fade_on_empty = false;
        }];
      };
    };
  };
}
