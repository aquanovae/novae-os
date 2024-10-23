{ config, inputs, lib, pkgs, username, ... }:

let
  looking-glass-kvmfr-experimental = config.boot.kernelPackages.kvmfr.overrideAttrs {
    version = "experimental";
    src = inputs.looking-glass-experimental;
  };

  looking-glass-client-experimental = pkgs.looking-glass-client.overrideAttrs {
    version = "experimental";
    src = inputs.looking-glass-experimental;
    patches = [];
  };
in {

  config = lib.mkIf config.ricos.programs.virtualisationApps.enable {
    home-manager.users.${username}.programs.looking-glass-client = {
      enable = true;
      package = looking-glass-client-experimental;

      settings = {
        win = {
          fullScreen = true;
          alerts = false;
        };

        input = {
          escapeKey = "KEY_INSERT";
          ignoreWindowsKeys = true;
        };
      };
    };

    environment.systemPackages = [
      looking-glass-kvmfr-experimental
    ];

    systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 ${username} users -"
    ];
  };
}
