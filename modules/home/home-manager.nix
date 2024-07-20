{ config, inputs, lib, ... }:

let
  cfg = config.ricos.home;
in {

  imports = [
    inputs.home-manager.nixosModules.default
  ];
  
  options.ricos.home = {
    enable = lib.mkEnableOption "enable home manager";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.rico = import ./home.nix;
  };
}
