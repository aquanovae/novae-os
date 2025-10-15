{ ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "silverlight";

  novaeOs = {
    desktopEnvironment = {
      enable = true;
      mode = "desktop";
    };

    hardware.wireless.enable = true;

    programs = {
      coolercontrol.enable = true;
      discord.enable = true;
      documentEditingApps.enable = true;
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
