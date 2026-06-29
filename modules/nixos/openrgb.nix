{ ... }: {

  flake.nixosModules.openrgb = { pkgs, ... }: {

    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "amd";
      startupProfile = "${../../assets/openrgb-startup.orp}";
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

    systemd.services.openrgb-startup = {
      path = [ pkgs.openrgb-with-all-plugins ];
      wantedBy = [
        "graphical.target"
        "sleep.target"
      ];
      after = [
        "multi-user.target"
        "sleep.target"
      ];
      before = [ "graphical.target" ];
      script = ''
        openrgb --profile ${../../assets/openrgb-startup.orp}
      '';
    };

    systemd.services.openrgb-suspend = {
      path = [ pkgs.openrgb-with-all-plugins ];
      serviceConfig.Type = "oneshot";
      wantedBy = [ "sleep.target" ];
      before = [ "sleep.target" ];
      script = ''
        openrgb --profile ${../../assets/openrgb-suspend.orp}
      '';
    };

    systemd.services.openrgb-shutdown = {
      path = [ pkgs.openrgb-with-all-plugins ];
      serviceConfig.Type = "oneshot";
      wantedBy = [ "shutdown.target" ];
      before = [ "shutdown.target" ];
      script = ''
        openrgb --profile ${../../assets/openrgb-shutdown.orp}
      '';
    };
  };
}
