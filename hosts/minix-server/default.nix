# ------------------------------------------------------------------------------
# Home server configuration
# ------------------------------------------------------------------------------
{ lib, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "minix-server";

  ricos = {
    server.enable = true;
  };

  # Override kernel config
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages;

  system.stateVersion = "24.05";
}
