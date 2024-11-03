# ------------------------------------------------------------------------------
# Custom ISO configuration
# ------------------------------------------------------------------------------
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
    # Override kernel config
    kernelPackages = lib.mkForce pkgs.linuxPackages;

    # Override grub config
    loader = {
      timeout = lib.mkForce 10;
      grub.enable = lib.mkForce false;
    };
  };

  # Fontconfig has to be explicitly enabled for live image
  fonts.fontconfig.enable = true;
}
