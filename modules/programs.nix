{ config, pkgs, ... }:

let
  cfg = config.ricos.programs;
in {

  environment.systemPackages = with pkgs; [
    devenv
    firefox
    gh
    gimp
    git
    grub2_efi
    inkscape
    lutris
    neofetch
    prismlauncher
    spotify
    tree
  ];

  programs = {
    coolercontrol.enable = cfg.enableCoolercontrol;
    htop.enable = true;
    steam.enable = true;
  };
}
