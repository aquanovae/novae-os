# ------------------------------------------------------------------------------
# Static IP address for server
# ------------------------------------------------------------------------------
{ config, lib, ... }:

let
  interface = "enp1s0";
in {

  config = lib.mkIf config.novaeOs.server.enable {
    networking = {
      interfaces.${interface}.ipv4.addresses = [{
        address = "10.7.7.7";
        prefixLength = 24;
      }];

      defaultGateway = {
        address = "10.7.7.1";
        interface = interface;
      };
    };
  };
}
