{ config, pkgs, ... }: {

  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 12;
      };

      colors = {
        primary = {
          background = "${config.colors.bg0}";
          foreground = "${config.colors.fg}";
        };

        cursor = {
          cursor = "${config.colors.fg}";
          text = "${config.colors.bg0}";
        };

        normal = {
          black = "${config.colors.gray}";
          red = "${config.colors.red}";
          green = "${config.colors.green}";
          yellow = "${config.colors.yellow}";
          blue = "${config.colors.blue}";
          magenta = "${config.colors.magenta}";
          cyan = "${config.colors.cyan}";
          white = "${config.colors.white}";
        };
      };

      window.opacity = 0.83;
    };
  };
}
