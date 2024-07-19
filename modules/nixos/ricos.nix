{ lib, ... }: {

  imports = [
    ./core/core.nix
    ./core/desktop.nix
  ];

  ricos = {
    core.enable = lib.mkDefault true;
    desktop.enable = lib.mkDefault true;
  };
}
