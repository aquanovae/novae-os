# ------------------------------------------------------------------------------
# Install programs
# ------------------------------------------------------------------------------
{ config, inputs, lib, pkgs, ... }: let

  cfg = config.novaeOs.programs;

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
    inputs.daily-playlist
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

  ] ++ lib.optionals cfg.documentEditingApps.enable [
    onlyoffice-desktopeditors
    pdfarranger
  ];

  programs = {
    coolercontrol.enable = cfg.coolercontrol.enable;
    htop.enable = true;
    steam.enable = cfg.steam.enable;
  };
}
