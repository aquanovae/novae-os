{ config, lib, ... }: {

  config = lib.mkIf config.novaeOs.server.enable {

    services.blocky = {
      enable = true;

      settings = {
        upstream.groups.default = [
        ];

        blocking = {
          blackLists.ads = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          ];

          clientGroupsBlock.default = [ "ads" ];
        };
      };
    };
  };
}
