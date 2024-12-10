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
    ./zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    extraPkgs.daily-playlist
    devenv
    expect
    jq
    gh
    git
    grub2_efi
    neofetch
    nix-output-monitor
    pulseaudio
    tree

  ] ++ lib.optionals cfg.defaultDesktopApps.enable [
    firefox
    pavucontrol
    spotify

  ] ++ lib.optionals cfg.gamingApps.enable [
    discord
    lutris
    prismlauncher
    wowup-cf

  ] ++ lib.optionals cfg.imageEditingApps.enable [
    inkscape
    gimp

  ] ++ lib.optionals cfg.vscode.enable [
    vscode
  ];

  programs = {
    coolercontrol.enable = cfg.coolercontrol.enable;
    htop.enable = true;
    steam.enable = cfg.gamingApps.enable;
  };
}
