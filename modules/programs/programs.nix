{ config, lib, pkgs, ... }:

let
  cfg = config.ricos.programs;
in {

  imports = [
    ./alacritty.nix
    ./gaming.nix
    ./openrgb.nix
  ];

  options.ricos.programs = {
    coolercontrol.enable = lib.mkEnableOption "enable coolercontrol";
  };

  config = {
    environment.systemPackages = with pkgs; [
      dex
      firefox
      gh
      gimp
      git
      grub2_efi
      inkscape
      neofetch
      playerctl
      radeontop
      spotify
      tree
    ];

    programs = {
      adb.enable = true;
      htop.enable = true;
      coolercontrol.enable = cfg.coolercontrol.enable;
    };

    users.users.rico.extraGroups = [ "adbusers" ];
  };
}
