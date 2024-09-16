{ lib, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages;

  system.stateVersion = "24.05";
};
