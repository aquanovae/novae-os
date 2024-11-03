# ------------------------------------------------------------------------------
# Laptop configuration
# ------------------------------------------------------------------------------
{ ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  ricos = {
    desktopEnvironment = {
      enable = true;
      waybar.modules = "laptop";
    };

    hardware = {
      # Unused because GPU is passed to virtual machine
      #nvidia.enable = true;
      wireless.enable = true;
    };

    programs = {
      defaultDesktopApps.enable = true;
      imageEditingApps.enable = true;
      vscode.enable = true;
    };

    virtualMachine = {
      enable = true;
      coreCount = "12";
      memory = "10G";
      gpuPassthrough = {
        enable = true;
        gpuId = "10de:25a0";
        gpuPciId = "01:00.0";
        fakeBattery.enable = true;
      };
    };
  };

  system.stateVersion = "23.11";
}

