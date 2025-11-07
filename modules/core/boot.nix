{ pkgs, ... }: {

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 2;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        splashImage = ./grub-background.png;
      };
    };

    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ "amdgpu" ];
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
    ];

    consoleLogLevel = 0;
    initrd.verbose = false;

    plymouth = {
      enable = true;
      theme = "nixos-bgrt";
      themePackages = [ pkgs.nixos-bgrt-plymouth ];
    };
  };
}
