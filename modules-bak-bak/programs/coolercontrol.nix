{ config, lib, pkgs, ... }: let

  coolercontrol-desktop-file = pkgs.makeDesktopItem {
    name = "cooler-control";
    desktopName = "cooler-control";
    type = "Application";
    exec = "${pkgs.coolercontrol.coolercontrol-gui}/bin/coolercontrol --disable-gpu";
    terminal = false;
  };

in {

  config = lib.mkIf config.novaeOs.programs.coolercontrol.enable {
    programs.coolercontrol.enable = true;
    environment.systemPackages = [ coolercontrol-desktop-file ];
  };
}
