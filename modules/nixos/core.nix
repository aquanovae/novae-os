{ ... }: {

  flake.nixosModules.core = { pkgs, ... }: {

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    programs = {
      ssh.startAgent = true;
      htop.enable = true;
    };

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
      splashImage = ../../assets/grub-background.png;
      useOSProber = true;
    };

    boot.plymouth = {
      enable = true;
      theme = "nixos-bgrt";
      themePackages = [ pkgs.nixos-bgrt-plymouth ];
    };

    time.timeZone = "Europe/Zurich";
    i18n.defaultLocale = "en_GB.UTF-8";
    console.keyMap = "fr_CH";
  };
}
