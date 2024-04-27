{ config, pkgs, ... }: {

  programs.alacritty = {
    enable = true;

    settings = {
      window.opacity = 0.83;

      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 12;
      };
    };
  };
}
