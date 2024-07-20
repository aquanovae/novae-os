{ config, lib, pkgs, ... }:

let
  cfg = config.ricos.programs.openrgb;

  openrgb = "${pkgs.openrgb}/bin/openrgb";
  configPath = "/home/rico/.config/OpenRGB";
in {

  options.ricos.programs.openrgb = {
    enable = lib.mkEnableOption "enable openrgb";
  };

  config = lib.mkIf cfg.enable {
    services = {
      udev.packages = [ pkgs.openrgb ];
      hardware.openrgb = {
        enable = true;
        package = pkgs.openrgb-with-all-plugins;
        motherboard = "amd";
      };
    };

    hardware.i2c.enable = true;

    boot = {
      kernelModules = [ "i2c-dev" "i2c-piix4" ];
      kernelParams = [ "acpi_enforce_resources=lax" ];
    };

    environment.systemPackages = [ pkgs.i2c-tools ];

    users.users.rico.extraGroups = [ "i2c" ];

    systemd.services.openrgb = {
      enable = true;
      postStart = ''
        sleep 2
        ${openrgb} -p ${configPath}/purple.orp
      '';

      preStop = ''
        ${openrgb} -p ${configPath}/off.orp
      '';
    };
  };
}
