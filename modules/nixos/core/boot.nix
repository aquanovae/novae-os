{ ... }: {

  flake.nixosModules.boot = { pkgs, ... }: {

    boot = {
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelPackages = pkgs.linuxPackages_zen;
      kernelModules = [ "amdgpu" ];
    };

    boot.kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
    ];

    boot.loader = {
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };

    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      splashImage = ../../../assets/grub-background.png;
      useOSProber = true;
    };

    boot.plymouth = {
      enable = true;
      theme = "nixos-bgrt";
      themePackages = [ pkgs.nixos-bgrt-plymouth ];
    };
  };
}
