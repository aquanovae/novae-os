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
          path = "/home/rico/.config/hypr/wallpaper.png";
          blur_passes = 3;
          blur_size = 5;
        }];

        input_field = [{
          size = "200, 50";
          outline_thickness = 2;
          outter_color = "rgb(${theme.blue})";
          inner_color = "rgb(${theme.bg0})";
        }];
      };
    };
  };
}
