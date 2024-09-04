{ ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "zenblade";
    wireless.iwd.enable = true;
  };

  system.stateVersion = "23.11";
}

