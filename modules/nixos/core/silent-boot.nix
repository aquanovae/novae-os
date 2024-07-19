{ config, lib, pkgs, ... }:

let
  cfg = config.ricos.silentBoot;
in {

  options.ricos.silentBoot = {
    enable = lib.mkEnableOption "enable silent boot";
  };

  config = lib.mkIf cfg.enable {
    initrd.verbose = false;
    console.LogLevel = 0;
    boot = {
      kernelModules = [
        "amdgpu"
      ];

      kernelParams = [
        "quiet"
        "splash"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
      ];

      plymouth = {
        enable = true;
        theme = "nixos-bgrt";
        themePackages = [
          pkgs.nixos-bgrt-plymouth
        ];
      };
    };
  };
}
