{ pkgs, ... }: {

  boot = {
    # Load GPU driver early to display splash screen
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
