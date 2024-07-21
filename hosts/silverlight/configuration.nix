{ ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "silverlight";

  ricos = {
    desktop.bar = {
      volume.enable = false;
      battery.enable = false;
    };

    programs = {
      openrgb.enable = true;
      gaming.enable = true;
      coolercontrol.enable = true;
    };
  };

  system.stateVersion = "24.05";
}
