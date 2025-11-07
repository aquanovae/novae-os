{ lib, modulesPath, pkgs, ... }: {

  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  networking.hostName = "live-image";

  novaeOs = {
    desktopEnvironment = {
      enable = true;
      mode = "minimal";
    };

    hardware = {
      wireless.enable = true;
    };
  };

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages;
    loader = {
      timeout = lib.mkForce 10;
      grub.enable = lib.mkForce false;
    };
  };

  fonts.fontconfig.enable = true;
}
