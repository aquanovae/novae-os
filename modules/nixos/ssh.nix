{ ... }: {

  flake.nixosModules.ssh = { ... }: {

    services.openssh = {
      enable = true;
      ports = [ 22 ];

      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    security.pam.sshAgentAuth.enable = true;
    nix.settings.trusted-users = [ "aquanovae" ];
    users.users.aquanovae.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIcGJirjfFVjalp0oCE9QxtSVkQm+eB3pqqeizfZwgXw"
    ];
  };
}
