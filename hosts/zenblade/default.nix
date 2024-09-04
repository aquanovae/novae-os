{ ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "zenblade";
    wireless.iwd.enable = true;
  };

  ricos = {
    waybar = {
      enableVolume = true;
      enableBattery = true;
    };
  };

  system.stateVersion = "23.11";
}

