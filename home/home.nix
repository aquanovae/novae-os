{ config, pkgs, ... }: {

  home.username = "rico";
  home.homeDirectory = "/home/rico";

  imports = [
    ./nvim/nvim.nix
    ./zsh.nix
  ];

  home.stateVersion = "23.11";
}
