{ config, lib, pkgs, ... }:

let
  cfg = config.ricos.programs;
in {

  imports = [
    ./alacritty.nix
    ./openrgb.nix
    ./nvim.nix
    ./starship.nix
    ./zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    devenv
    expect
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
