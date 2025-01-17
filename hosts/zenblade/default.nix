# ------------------------------------------------------------------------------
# Laptop configuration
# ------------------------------------------------------------------------------
{ ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "zenblade";

  novaeOs = {
    desktopEnvironment = {
      enable = true;
      mode = "laptop";
    };

    hardware = {
      # Unused because GPU is passed to virtual machine
      nvidia.enable = true;
      wireless.enable = true;
    };

    programs = {
      defaultDesktopApps.enable = true;
      documentEditingApps.enable = true;
      imageEditingApps.enable = true;
      spotify.enable = true;
      steam.enable = true;
      vscode.enable = true;
    };

    virtualMachine = {
      enable = true;
      coreCount = "12";
      memory = "10G";
      /*
      gpuPassthrough = {
        enable = true;
        gpuId = "10de:25a0";
        gpuPciId = "01:00.0";
        fakeBattery.enable = true;
      };
      */
    };
  };

  system.stateVersion = "23.11";
}

