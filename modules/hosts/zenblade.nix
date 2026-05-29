{ inputs, self, ... }: {

  flake.nixosConfigurations.zenblade = inputs.nixpkgs.lib.nixosSystem {

    modules = with self.nixosModules; [
      zenblade

      core
      desktop
      programsFull
      waybarZenblade
      wireless
    ];
  };

  flake.nixosModules.zenblade = { modulesPath, ... }: {

    networking.hostName = "zenblade";

    system.stateVersion = "23.11";

    # Hardware configuration
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot.kernelModules = [ "kvm-amd" ];
    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/195abbd2-fab5-4be8-9a43-2f12ff8871fd";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/3969-43D0";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

    networking.useDHCP = true;

    nixpkgs.hostPlatform = "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = true;
  };
}
