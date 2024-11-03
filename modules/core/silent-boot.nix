# ------------------------------------------------------------------------------
# Hide log messages on boot
# ------------------------------------------------------------------------------
{ pkgs, ... }: {

  boot = {
    # Load GPU driver early to display splash screen
    kernelModules = [ "amdgpu" ];

    # Log message suppression
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
    ];

    consoleLogLevel = 0;
    initrd.verbose = false;

    # Splash screen config
    plymouth = {
      enable = true;
      theme = "nixos-bgrt";
      themePackages = [
        pkgs.nixos-bgrt-plymouth
      ];
    };
  };
}
