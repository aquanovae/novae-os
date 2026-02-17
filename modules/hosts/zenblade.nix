{ inputs, self, ... }: let
    novaepkgs = let
      callNovaePackage = package: inputs.${package}.packages.x86_64-linux.default;
    in{
      spotify-daily = callNovaePackage "spotify-daily";
      spotify-info = callNovaePackage "spotify-info";
    };

in {
  flake.nixosConfigurations.zenblade = inputs.nixpkgs.lib.nixosSystem {

    specialArgs = { inherit inputs novaepkgs; };
    modules = with self.nixosModules; [
      zenblade
      core
      neovim
      starship
      theme
      user
      zsh

      inputs.spicetify-nix.nixosModules.default
      inputs.home-manager.nixosModules.default
      inputs.nixvim.nixosModules.default

      ../../modules-bak-bak
    ];
  };


  flake.nixosModules.zenblade = { config, lib, ... }: {

    networking.hostName = "zenblade";

    novaeOs = {
      desktopEnvironment = {
        enable = true;
        mode = "laptop";
      };

      hardware = {
        nvidia.enable = true;
        wireless.enable = true;
      };

      programs = {
        circuitsApps.enable = true;
        documentEditingApps.enable = true;
        imageEditingApps.enable = true;
        spotify.enable = true;
        steam.enable = true;
        vscode.enable = true;
      };

      virtualMachine = {
        enable = true;
        coreCount = "8";
        memory = "6G";
        laptopUsbPassthrough.enable = true;
        gpuPassthrough = {
          enable = false;
          gpuId = "10de:25a0";
          gpuPciId = "01:00.0";
          fakeBattery.enable = false;
        };
      };
    };

    system.stateVersion = "23.11";
    home-manager.users.aquanovae.home.stateVersion = "23.11";

    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];

    boot.kernelModules = [ "kvm-amd" ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/195abbd2-fab5-4be8-9a43-2f12ff8871fd";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/3969-43D0";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
