{ config, lib, ... }: {

  config = lib.mkIf config.novaeOs.hardware.wireless.enable {
    networking.wireless = {
      enable = false;
      iwd.enable = true;
    };
  };
}
