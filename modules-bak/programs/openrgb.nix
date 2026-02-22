{ config, inputs, lib, pkgs, username, ... }: let

  openrgbPatch = pkgs.writeText "openrgb.patch" ''
    diff --git a/OpenRGB.pro b/OpenRGB.pro
    index e2228751..06304437 100644
    --- a/OpenRGB.pro
    +++ b/OpenRGB.pro
    @@ -590,7 +590,7 @@ contains(QMAKE_PLATFORM, linux) {
         metainfo.files+=qt/org.openrgb.OpenRGB.metainfo.xml
         systemd_service.path=$$PREFIX/lib/systemd/system/
         systemd_service.files+=qt/openrgb.service
    -    INSTALLS += target desktop icon metainfo udev_rules systemd_service
    +    INSTALLS += target desktop icon metainfo udev_rules
     }

     #-----------------------------------------------------------------------------------------------#
  '';
  
  openrgb = pkgs.openrgb-with-all-plugins.overrideAttrs {
    version = "1.0rc2";
    src = inputs.openrgb;
    patches = [
      "${openrgbPatch}"
    ];
    postPatch = ''
      patchShebangs scripts/build-udev-rules.sh
      substituteInPlace scripts/build-udev-rules.sh \
        --replace-fail "/usr/bin/env chmod" "${pkgs.coreutils}/bin/chmod"
    '';
  };

  openrgbEffectsPluginPatch = pkgs.writeText "openrgb-effects-plugin.patch" ''
    diff --git a/OpenRGBEffectsPlugin.pro b/OpenRGBEffectsPlugin.pro
    index bd6023d..80b0e99 100644
    --- a/OpenRGBEffectsPlugin.pro
    +++ b/OpenRGBEffectsPlugin.pro
    @@ -24,7 +24,6 @@ TEMPLATE = lib
     #-----------------------------------------------------------------------------------------------#
     CONFIG +=                                                                                       \
         embed_translations                                                                          \
    -    lrelease                                                                                    \
         plugin                                                                                      \
         silent                                                                                      \

    @@ -106,6 +105,9 @@ INCLUDEPATH +=
         OpenRGB/qt                                                                                  \
         OpenRGB/i2c_smbus                                                                           \
         OpenRGB/net_port                                                                            \
    +    OpenRGB/SPDAccessor                                                                         \
    +    OpenRGB/dependencies/hidapi-win/include                                                     \
    +    OpenRGB/hidapi_wrapper                                                                      \

     HEADERS +=                                                                                      \
         OpenRGB/Colors.h                                                                            \
  '';

  openrgb-effects-plugin = pkgs.openrgb-plugin-effects.overrideAttrs (final: prev: {
    version = "1.0rc2";
    src = inputs.openrgb-effects-plugin;
    patches = [
      "${openrgbEffectsPluginPatch}"
    ];
    postPatch = /*bash*/ ''
      rm -r OpenRGB
      ln -s ${openrgb.src} OpenRGB
      substituteInPlace OpenRGBEffectsPlugin.pro \
        --replace-fail "/usr/include/pipewire-0.3" "${pkgs.pipewire.dev}/include/pipewire-0.3" \
        --replace-fail "/usr/include/spa-0.2" "${pkgs.pipewire.dev}/include/spa-0.2" 
    '';
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

    systemd.packages = [ openrgb ];

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
      configPath = "/home/${username}/.config/OpenRGB";
    in {
      enable = true;
      path = [ openrgb ];
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
