{ config, lib, username, ... }: let

  theme = config.novaeOs.theme;

in {

  config = lib.mkIf config.novaeOs.desktopEnvironment.enable {
    home-manager.users.${username}.programs.alacritty = {
      enable = true;

      settings = {
        window.opacity = 0.83;

        font = {
          normal.family = "JetBrainsMono Nerd Font";
          size = 12;
        };

        colors = {
          primary = {
            background = "#${theme.bg0}";
            foreground = "#${theme.fg}";
          };

          cursor = {
            cursor = "#${theme.fg}";
            text = "#${theme.bg0}";
          };

          normal = {
            black = "#${theme.gray}";
            red = "#${theme.red}";
            green = "#${theme.green}";
            yellow = "#${theme.yellow}";
            blue = "#${theme.blue}";
            magenta = "#${theme.magenta}";
            cyan = "#${theme.cyan}";
            white = "#${theme.fg}";
          };
        };

        keyboard.bindings = [{
          mods = "Control";
          key = "Enter";
          action = "SpawnNewInstance";
        }];
      };
    };
  };
}
