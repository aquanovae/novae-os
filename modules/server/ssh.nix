# ------------------------------------------------------------------------------
# Ssh server configuration
# ------------------------------------------------------------------------------
{ config, lib, username, ... }: {

  config = lib.mkIf config.novaeOs.server.enable {
    services.openssh = {
      enable = true;
      ports = [ 777 ];

      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    users.users.${username}.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIcGJirjfFVjalp0oCE9QxtSVkQm+eB3pqqeizfZwgXw rico"
    ];
  };
}
