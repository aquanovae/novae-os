{ config, lib, ... }: let

  theme = config.novaeos.theme;

in {

  config = lib.mkIf config.novaeOs.desktopEnvironment.enable {
    home-manager.users.${config.novaeos.username}.programs.alacritty = {
      enable = true;

      settings = {
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
            black = "#${theme.black}";
            red = "#${theme.red}";
            green = "#${theme.green}";
            yellow = "#${theme.yellow}";
            blue = "#${theme.blue}";
            magenta = "#${theme.magenta}";
            cyan = "#${theme.cyan}";
            white = "#${theme.white}";
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
