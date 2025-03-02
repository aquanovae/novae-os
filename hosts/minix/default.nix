{ lib, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "minix-server";

  novaeOs = {
    server.enable = true;
  };

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages;
    plymouth.enable = lib.mkForce false;
  };

  system.stateVersion = "24.05";
}
