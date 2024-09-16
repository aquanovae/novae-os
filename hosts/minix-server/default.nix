{ lib, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  ricos = {
    desktopEnvironment.enable = false;

    programs = {
      coolercontrol.enable = false;
      defaultDesktopApps.enable = false;
      gamingApps.enable = false;
      imageEditingApps.enable = false;
      openrgb.enable = false;
      virtualisationApps.enable = false;
    };

    server = {
      ssh.enable = true;
    };
  };

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages;

  system.stateVersion = "24.05";
}
