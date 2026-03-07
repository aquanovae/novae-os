{ ... }: {

  flake.nixosModules.openrgb = { pkgs, ... }: {

    services.udev.packages = [ pkgs.openrgb ];
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "amd";
    };

    hardware.i2c.enable = true;
    users.users.aquanovae.extraGroups = [ "i2c" ];

    environment.systemPackages = [ pkgs.i2c-tools ];

    boot = {
      kernelModules = [
        "i2c-dev"
        "i2c-piix4"
      ];

      # Conflicts with DRAM i2c interface
      blacklistedKernelModules = [ "spd5118" ];

      # Resolve conflict with SMBus controller
      kernelParams = [ "acpi_enforce_resources=lax" ];
    };

    systemd.packages = [ pkgs.openrgb ];

    systemd.services.openrgb = let
      configPath = "/home/aquanovae/.config/OpenRGB";
    in {
      enable = true;
      path = [ pkgs.openrgb ];
      postStart = ''
        sleep 2
        openrgb -p ${configPath}/purple.orp
      '';
      preStop = ''
        openrgb -p ${configPath}/off.orp
      '';
    };
  };
}
