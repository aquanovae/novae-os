{ ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "zenblade";
    wireless.iwd.enable = true;
  };

  ricos = {
    enableNvidia = true;

    programs = {
      enableCoolercontrol = false;
      enableOpenrgb = false;
    };

    waybar = {
      enableVolume = true;
      enableBattery = true;
    };
  };

  system.stateVersion = "23.11";
}

