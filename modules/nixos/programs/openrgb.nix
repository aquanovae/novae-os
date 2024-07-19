{ config, lib, pkgs, ... }:

let
  cfg = config.ricos.programs.openrgb;
in {

  options.ricos.programs.openrgb = {
    enable = lib.mkEnableOption "enable openrgb";
  };

  config = lib.mkIf cfg.enable {
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "amd";
    };

    systemd.services.openrgb =
    let
      openrgb = "${pkgs.openrgb}/bin/openrgb";
      configPath = "/home/rico/.config/OpenRGB";
    in {

      enable = true;
      postStart = ''
        sleep 5
        ${openrgb} -p ${configPath}/purple.orp
      '';

      preStop = ''
        ${openrgb} -p ${configPath}/off.orp
      '';
    };
  };
}
