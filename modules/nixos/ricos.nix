{ config, lib, ... }: {

  imports = [
    ./core/core.nix
    ./core/desktop.nix
    ./core/silent-boot.nix

    ./programs/base.nix
    ./programs/gaming.nix
  ];

  ricos = {
    core.enable = lib.mkDefault true;
    desktop.enable = lib.mkDefault true;
    silentBoot.enable = lib.mkDefault true;

    programs = lib.mkIf config.ricos.desktop.enable {
      base.enable = lib.mkDefault true;
      gaming.enable = lib.mkDefault false;
    };
  };
}
