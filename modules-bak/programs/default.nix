{ config, lib, pkgs, ... }: let

  cfg = config.novaeOs.programs;

in {

  imports = [
    ./openrgb.nix
    ./ranger.nix
    ./syncthing
  ];

}
