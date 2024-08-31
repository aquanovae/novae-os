{ config, pkgs, ... }:

let
  cfg = config.ricos.programs;
in {

  environment.systemPackages = with pkgs; [
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
