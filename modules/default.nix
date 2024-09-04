{ inputs, lib, username, ... }: {

  imports = [
    ./core
    ./desktop-environment
    ./programs

    inputs.home-manager.nixosModules.home-manager
  ];

  options.ricos = {
    waybar = {
      enableVolume = lib.mkEnableOption "show volume module in bar";
      enableBattery = lib.mkEnableOption "show battery module in bar";
    };
  };

  config.home-manager.users.${username}.home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    stateVersion = "23.11";
  };
}
