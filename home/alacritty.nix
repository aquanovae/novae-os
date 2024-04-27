{ config, pkgs, ... }: {

  programs.alacritty = {
    enable = true;

    settings = {
      window.opacity = 0.83;

      font = {
        family = "JetBrainsMono Nerd Font";
        size = 8;
      };
    };
  }
}
