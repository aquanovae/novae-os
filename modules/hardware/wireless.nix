{ config, lib, ... }: {

  config = lib.mkIf config.ricos.hardware.wireless.enable {
    networking.wireless = {
      enable = false;
      iwd.enable = true;
    };
  };
}
