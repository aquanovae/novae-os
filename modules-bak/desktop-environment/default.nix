{ config, lib, pkgs, novaepkgs, ... }: {

  imports = [
    ./menus
  ];

  config = lib.mkIf config.novaeOs.desktopEnvironment.enable {

    environment.systemPackages = with pkgs; [
      bemenu
      dex
      firefox
      pulseaudio
      pwvucontrol
    ];
  };
}
