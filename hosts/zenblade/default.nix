{ ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  ricos = {
    desktopEnvironment = {
      enable = true;
      waybar.modules = "laptop";
    };

    programs = {
      coolercontrol.enable = false;
      defaultDesktopApps.enable = true;
      gamingApps.enable = false;
      imageEditingApps.enable = true;
      openrgb.enable = false;
      virtualisationApps.enable = false;
    };
  };

  system.stateVersion = "23.11";
}

