# ------------------------------------------------------------------------------
# Install programs
# ------------------------------------------------------------------------------
{ config, lib, outputs, pkgs, system, ... }:

# Warnings to be dealt with someday
let
  cfg = config.ricos.programs;

  extraPkgs = outputs.packages.${system};
in {

  imports = [
    ./alacritty.nix
    ./openrgb.nix
    ./nvim.nix
    ./ranger.nix
    ./starship.nix
    ./spotify.nix
    ./zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    extraPkgs.daily-playlist
    jq
    gh
    git
    neofetch
    pulseaudio
    tree

  ] ++ lib.optionals cfg.defaultDesktopApps.enable [
    firefox
    pavucontrol

  ] ++ lib.optionals cfg.imageEditingApps.enable [
    inkscape
    gimp
  ];

  programs = {
    coolercontrol.enable = cfg.coolercontrol.enable;
    htop.enable = true;
    steam.enable = cfg.steam.enable;
  };
}
