{ inputs, self, ... }: {
  
  flake.nixosConfigurations.minix = inputs.nixpkgs.lib.nixosSystem {

    modules = with self.nixosModules; [
      minix

      core
      dailyPlaylist
      ssh
    ];
  };

  flake.nixosModules.minix = { lib, modulesPath, pkgs, ... }: {

    networking.hostName = "minix";

    boot.kernelPackages = lib.mkForce pkgs.linuxPackages;

    system.stateVersion = "24.05";

    # Hardware configuration
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot.kernelModules = [ "kvm-intel" ];
    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
      "sdhci_pci"
    ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/b9f2f71f-970b-4439-9bc0-24ea66a711bf";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/3445-5CA1";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

    networking.useDHCP = true;

    nixpkgs.hostPlatform = "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = true;
  };
}
