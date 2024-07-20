{ ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "silverlight";

  ricos = {
    core.enable = true;
    silentBoot.enable = true;

    desktop.enable = true;
    home.enable = true;

    programs = {
      base.enable = true;
      openrgb.enable = true;
      gaming.enable = true;
    };
  };

  programs = {
    coolercontrol.enable = true;
  };

  system.stateVersion = "24.05";
}
