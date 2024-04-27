{ config, pkgs, ... }: {

  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 12;
      };

      colors.primary.background = "${config.colors.bg}";

      window.opacity = 0.83;
    };
  };
}
