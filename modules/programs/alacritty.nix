{ config, pkgs, ... }: {

  environment.systemPackages = [ pkgs.alacritty ];

  home-manager.users.rico.programs.alacritty = {
    enable = true;

    settings = {
      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 12;
      };

      colors = with config.ricos.theme; {
        primary = {
          background = "#${bg0}";
          foreground = "#${fg}";
        };

        cursor = {
          cursor = "#${fg}";
          text = "#${bg0}";
        };

        normal = {
          black = "#${gray}";
          red = "#${red}";
          green = "#${green}";
          yellow = "#${yellow}";
          blue = "#${blue}";
          magenta = "#${magenta}";
          cyan = "#${cyan}";
          white = "#${fg}";
        };
      };

      window.opacity = 0.83;
    };
  };
}
