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

  fileSystems = let options = {
    options = [ "noatime" "ssd" "discard" ];
  }; in {
    "/" = options;
    "/nix" = options;
    "/home" = options;
    "/home/rico/rstore" = options;
  };

  boot = {
    initrd = {
      systemd.enable = true;
      luks.devices."root".allowDiscards = true;
      supportedFilesystems = [ "btrfs" ];
      verbose = false;
    };
  };

  system.stateVersion = "23.11";
}

