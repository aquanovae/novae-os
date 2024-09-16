{ inputs, lib, modulesPath, pkgs, username, ... }: {

  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  ricos = {
    desktopEnvironment = {
      enable = true;
      waybar.modules = "minimal";
    };

    programs = {
      coolercontrol.enable = false;
      defaultDesktopApps.enable = true;
      gamingApps.enable = false;
      imageEditingApps.enable = false;
      openrgb.enable = false;
      virtualisationApps.enable = false;
    };
  };

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages;
    loader = {
      timeout = lib.mkForce 10;
      grub.enable = lib.mkForce false;
    };
  };

  home-manager.users.${username}.home.file = {
    "ricos".source = inputs.ricos;
  };

  fonts.fontconfig.enable = true;
}
