{ ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  networking.wireless.iwd.enable = true;

  system.stateVersion = "23.11";
}

