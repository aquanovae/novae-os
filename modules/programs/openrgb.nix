# ------------------------------------------------------------------------------
# Openrgb configuration
# ------------------------------------------------------------------------------
{ config, inputs, lib, pkgs, username, ... }:

let
  openrgb = "${pkgs.openrgb}/bin/openrgb";
  configPath = "/home/rico/.config/OpenRGB";
in {

  config = lib.mkIf config.ricos.programs.openrgb.enable {
    services = {
      # Install udev rules
      udev.packages = [ pkgs.openrgb ];

      hardware.openrgb = {
        enable = true;
        motherboard = "amd";

        # Override package with experimental version
        package = pkgs.openrgb.overrideAttrs {
          version = "experimental";
          src = inputs.openrgb-experimental;
          postPatch = ''
            patchShebangs scripts/build-udev-rules.sh
            substituteInPlace scripts/build-udev-rules.sh \
              --replace "/usr/bin/env chmod" "${pkgs.coreutils}/bin/chmod"
          '';
        };
      };
    };

    # Enable i2c access
    hardware.i2c.enable = true;
    environment.systemPackages = [ pkgs.i2c-tools ];
    users.users.${username}.extraGroups = [ "i2c" ];

    boot = {
      # Load i2c drivers
      kernelModules = [ "i2c-dev" "i2c-piix4" ];
      kernelParams = [ "acpi_enforce_resources=lax" ];
    };

    systemd.services.openrgb = {
      enable = true;

      # Load profile on startup
      postStart = ''
        sleep 5
        ${openrgb} -p ${configPath}/purple.orp
      '';

      # Turn off LEDs on shutdown
      preStop = ''
        ${openrgb} -p ${configPath}/off.orp
      '';
    };
  };
}
