{ config, lib, pkgs, ... }: {

  config = lib.mkIf config.novaeOs.server.enable {

    users.users.git = {
      isSystemUser = true;
      group = "git";
      home = "/home/git-server";
      createHome = true;
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKxewg9E0syKklfRjSqMjzIjUMXq5PODo+omtfaRicXp"
      ];
    };

    users.groups.git = {};
  };
}
