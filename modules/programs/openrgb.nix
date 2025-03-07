{ config, inputs, lib, pkgs, username, ... }: let

  # Override nixpkgs source with git master
  openrgb = pkgs.openrgb-with-all-plugins.overrideAttrs {
    version = "master";
    src = inputs.openrgb;
    postPatch = ''
      patchShebangs scripts/build-udev-rules.sh
      substituteInPlace scripts/build-udev-rules.sh \
        --replace "/usr/bin/env chmod" "${pkgs.coreutils}/bin/chmod"
    '';
  };
  openrgb-effects-plugin = pkgs.openrgb-plugin-effects.overrideAttrs (final: prev: {
    version = "master";
    src = inputs.openrgb-effects-plugin;
    postPatch = /*bash*/ ''
      rm -r OpenRGB
      ln -s ${openrgb.src} OpenRGB
      substituteInPlace OpenRGBEffectsPlugin.pro \
        --replace "/usr/include/pipewire-0.3" "${pkgs.pipewire.dev}/include/pipewire-0.3" \
        --replace "/usr/include/spa-0.2" "${pkgs.pipewire.dev}/include/spa-0.2" 
      substituteInPlace ./*.h ./Audio/*.h ./Effects/*.h ./Effects/**/*.h \
        --replace "\"json.hpp\"" "<nlohmann/json.hpp>"
    '';
    nativeBuildInputs = prev.nativeBuildInputs ++ [
      pkgs.libsForQt5.qttools
    ];
    buildInputs = prev.buildInputs ++ [
      pkgs.pipewire
    ];
  });

in {

  config = lib.mkIf config.novaeOs.programs.openrgb.enable {
    services = {
      udev.packages = [ openrgb ];

      hardware.openrgb = {
        enable = true;
        motherboard = "amd";
        package = openrgb;
      };
    };

    hardware.i2c.enable = true;
    users.users.${username}.extraGroups = [ "i2c" ];

    environment.systemPackages = [
      openrgb-effects-plugin
      pkgs.i2c-tools
    ];

    home-manager.users.${username}.home = {
      file.".config/OpenRGB/plugins/libOpenRGBEffectsPlugin.so" = {
        source = "${openrgb-effects-plugin}/lib/openrgb/plugins/libOpenRGBEffectsPlugin.so";
      };
    };

    boot = {
      kernelModules = [ "i2c-dev" "i2c-piix4" ];

      # Conflicts with DRAM i2c interface
      blacklistedKernelModules = [ "spd5118" ];

      # Resolve conflict with SMBus controller
      kernelParams = [ "acpi_enforce_resources=lax" ];
    };

    systemd.services.openrgb = let

      openrgb = "${pkgs.openrgb}/bin/openrgb";
      configPath = "/home/${username}/.config/OpenRGB";

    in {

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
