{ inputs, lib, ... }: {

  imports = [
    ./core
    ./desktop-environment
    ./programs.nix
    ./system/system.nix

    inputs.home-manager.nixosModules.home-manager
  ];

  options.ricos = {
    enableNvidia = lib.mkEnableOption "enable nvidia";

    programs = {
      enableCoolercontrol = lib.mkEnableOption "enable coolercontrol";
      enableOpenrgb = lib.mkEnableOption "enable openrgb";
    };

    waybar = {
      enableVolume = lib.mkEnableOption "show volume module in bar";
      enableBattery = lib.mkEnableOption "show battery module in bar";
    };
  };

  config = {
    home-manager.users.rico = import ./home/home.nix;
  };
}
