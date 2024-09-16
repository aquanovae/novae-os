{ config, lib, ... }: {

  config = lib.mkIf config.ricos.server.ssh.enable {
    services.openssh = {
      enable = true;

      settings = {
        PermitRootLogin = "no";
      };
    };
  };
}
