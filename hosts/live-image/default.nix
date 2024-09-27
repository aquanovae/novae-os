{ lib, modulesPath, pkgs, ... }: {

  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  ricos = {
    desktopEnvironment = {
      enable = true;
      waybar.modules = "minimal";
    };

    hardware = {
      wireless.enable = true;
    };

    programs = {
      defaultDesktopApps.enable = true;
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
