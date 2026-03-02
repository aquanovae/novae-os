{ ... }: {

  flake.nixosModules.openrgb = { pkgs, ... }: {

    services.udev.packages = [ pkgs.openrgb ];
    services.hardware.openrgb = {
      enable = true;
      motherboard = "amd";
    };

    systemd.packages = [ pkgs.openrgb ];

    hardware.i2c.enable = true;
    users.users.aquanovae.extraGroups = [ "i2c" ];

    environment.systemPackages = with pkgs; [
      openrgb-effects-plugin
      i2c-tools
    ];

    home-manager.users.aquanovae.home = {
      file.".config/OpenRGB/plugins/libOpenRGBEffectsPlugin.so" = {
        source = "${pkgs.openrgb-effects-plugin}/lib/openrgb/plugins/libOpenRGBEffectsPlugin.so";
      };
    };

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
