# ------------------------------------------------------------------------------
# Desktop computer configuration
# ------------------------------------------------------------------------------
{ ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "silverlight";

  ricos = {
    desktopEnvironment = {
      enable = true;
      mode = "desktop";
    };

    programs = {
      coolercontrol.enable = true;
      defaultDesktopApps.enable = true;
      imageEditingApps.enable = true;
      openrgb.enable = true;
      spotify.enable = true;
      steam.enable = true;
    };

    /*
    virtualMachine = {
      enable = true;
      coreCount = "20";
      memory = "16G";
      gpuPassthrough.enable = false;
    };
    */
  };

  system.stateVersion = "24.05";
}
