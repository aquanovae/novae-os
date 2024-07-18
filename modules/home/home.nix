{ config, pkgs, ... }: {

  home.username = "rico";
  home.homeDirectory = "/home/rico";

  imports = [
    ./theme/theme.nix

    ./alacritty.nix
    ./hyprland.nix
    ./nvim/nvim.nix
    ./starship.nix
    ./waybar/waybar.nix
    ./zsh.nix
  ];

  home.stateVersion = "23.11";
}
