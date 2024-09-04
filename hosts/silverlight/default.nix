{ ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "silverlight";

  ricos = {
    waybar = {
      enableVolume = false;
      enableBattery = false;
    };
  };

  system.stateVersion = "24.05";
}
