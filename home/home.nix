{ config, pkgs, ... }: {

  home.username = "rico";
  home.homeDirectory = "/home/rico";

  imports = [
    ./theme/theme.nix

    ./alacritty.nix
    ./nvim/nvim.nix
    ./starship.nix
    ./zsh.nix
  ];

  home.stateVersion = "23.11";
}
