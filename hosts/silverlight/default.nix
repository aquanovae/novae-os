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
    };

    virtualMachine = {
      enable = true;
      coreCount = "20";
      memory = "16G";
      gpuPassthrough.enable = false;
    };
  };

  system.stateVersion = "24.05";
}
