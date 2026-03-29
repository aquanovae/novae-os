{ inputs, self, ... }: {

  flake.nixosConfigurations.silverlight = inputs.nixpkgs.lib.nixosSystem {

    modules = with self.nixosModules; [
      silverlight

      core
      desktop
      hyprlandDualMonitor
      programsSilverlight
      waybarSilverlight
      wireless
    ];
  };

  flake.nixosModules.silverlight = { modulesPath, ... }: {

    networking.hostName = "silverlight";

    system.stateVersion = "24.05";

    # Hardware configuration
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot.kernelModules = [ "kvm-amd" ];
    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/aaf146d2-b32e-4808-a772-3dd3bea216bd";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/2A7C-EF90";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

    networking.useDHCP = true;

    nixpkgs.hostPlatform = "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = true;
  };
}
