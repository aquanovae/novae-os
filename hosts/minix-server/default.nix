{ lib, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  ricos = {
    server.enable = true;
  };

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages;

  system.stateVersion = "24.05";
}
