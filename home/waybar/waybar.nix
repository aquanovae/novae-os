{ config, pkgs, ... }: {

  programs.waybar = {
    enable = true;

    settings = {
      layer = "top";
      position = "bottom";
      height = 34;

      modules-left = [ "hyprland/workspace" ];
    };
  };
};
