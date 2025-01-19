# ------------------------------------------------------------------------------
# Install programs
# ------------------------------------------------------------------------------
{ config, lib, outputs, pkgs, system, ... }: let

  cfg = config.novaeOs.programs;

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
