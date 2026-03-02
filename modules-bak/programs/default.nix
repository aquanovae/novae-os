{ config, lib, pkgs, ... }: let

  cfg = config.novaeOs.programs;

in {

  imports = [
    ./syncthing
  ];

}
