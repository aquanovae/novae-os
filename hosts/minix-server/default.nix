# ------------------------------------------------------------------------------
# Home server configuration
# ------------------------------------------------------------------------------
{ lib, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "minix-server";

  novaeOs = {
    server.enable = true;
  };

  boot = {
    # Override kernel config
    kernelPackages = lib.mkForce pkgs.linuxPackages;

    # Disable plymouth
    plymouth.enable = lib.mkForce false;
  };

  system.stateVersion = "24.05";
}
