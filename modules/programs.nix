{ config, pkgs, ... }:

let
  cfg = config.ricos.programs;
in {

  environment.systemPackages = with pkgs; [
    brightnessctl
    devenv
    dex
    firefox
    gh
    gimp
    git
    grub2_efi
    inkscape
    lutris
    neofetch
    pamixer
    playerctl
    prismlauncher
    radeontop
    spotify
    tree
  ];

  programs = {
    coolercontrol.enable = cfg.enableCoolercontrol;
    htop.enable = true;
    steam.enable = true;
  };
}
