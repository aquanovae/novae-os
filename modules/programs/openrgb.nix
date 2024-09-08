{ inputs, pkgs, username, ... }:

let
  openrgb = "${pkgs.openrgb}/bin/openrgb";
  configPath = "/home/rico/.config/OpenRGB";
in {

  services = {
    udev.packages = [ pkgs.openrgb ];
    hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb.overrideAttrs {
        version = "experimental";
        src = inputs.openrgb-experimental;
      };
      motherboard = "amd";
    };
  };

  hardware.i2c.enable = true;

  boot = {
    kernelModules = [ "i2c-dev" "i2c-piix4" ];
    kernelParams = [ "acpi_enforce_resources=lax" ];
  };

  environment.systemPackages = [ pkgs.i2c-tools ];

  users.users.${username}.extraGroups = [ "i2c" ];

  systemd.services.openrgb = {
    enable = true;
    postStart = ''
      sleep 5
      ${openrgb} -p ${configPath}/purple.orp
    '';

    preStop = ''
      ${openrgb} -p ${configPath}/off.orp
    '';
  };
}
