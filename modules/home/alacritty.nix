{ osConfig, ... }:

let
  theme = osConfig.ricos.theme;
in {

  programs.alacritty = {
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

      window.opacity = 0.83;
    };
  };
}
