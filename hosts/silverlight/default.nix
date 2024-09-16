{ ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  ricos = {
    desktopEnvironment = {
      enable = true;
      waybar.modules = "desktop";
    };

    programs = {
      coolercontrol.enable = true;
      defaultDesktopApps.enable = true;
      gamingApps.enable = true;
      imageEditingApps.enable = true;
      openrgb.enable = true;
      virtualisationApps.enable = true;
    };
  };

  system.stateVersion = "24.05";
}
