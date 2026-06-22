{ ... }: {

  flake.nixosModules.openrgb = { pkgs, ... }: {

    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "amd";
      startupProfile = ../../assets/openrgb-startup.orp;
    };

    hardware.i2c.enable = true;
    users.users.aquanovae.extraGroups = [ "i2c" ];

    environment.systemPackages = [ pkgs.i2c-tools ];

    boot = {
      # Conflicts with DRAM i2c interface
      blacklistedKernelModules = [ "spd5118" ];

      # Resolve conflict with SMBus controller
      kernelParams = [ "acpi_enforce_resources=lax" ];
    };

    systemd.services.openrgb.preStop = ''
      openrgb --profile ${../../assets/openrgb-shutdown.orp}
    '';
  };
}
