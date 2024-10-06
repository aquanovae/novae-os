{ config, lib, pkgs, ... }:

let
  cfg = config.ricos.programs;
in {

  imports = [
    ./alacritty.nix
    ./openrgb.nix
    ./nvim.nix
    ./starship.nix
    ./virtual-machine.nix
    ./zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    devenv
    gh
    git
    grub2_efi
    neofetch
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
