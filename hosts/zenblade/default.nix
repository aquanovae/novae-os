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
      nvidia.enable = true;
      wireless.enable = true;
    };

    programs = {
      circuitsApps.enable = true;
      documentEditingApps.enable = true;
      imageEditingApps.enable = true;
      spotify.enable = true;
      steam.enable = true;
      vscode.enable = true;
    };

    virtualMachine = {
      enable = false;
      coreCount = "12";
      memory = "10G";
      gpuPassthrough = {
        enable = false;
        gpuId = "10de:25a0";
        gpuPciId = "01:00.0";
        fakeBattery.enable = true;
      };
    };
  };

  system.stateVersion = "23.11";
}

