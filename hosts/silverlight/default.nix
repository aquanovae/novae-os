{ ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "silverlight";

  system.stateVersion = "24.05";
}
