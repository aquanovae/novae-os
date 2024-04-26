{ config, pkgs, ... }:

{
  home.username = "rico";
  home.homeDirectory = "/home/rico";

  imports = [
    ./nvim.nix
  ];

  home.stateVersion = "23.11";
}
