{ config, lib, ... }: {

  config = lib.mkIf config.novaeOs.server.enable {

    services.blocky = {
      enable = true;

      settings = {
        upstream.groups = [
          "194.230.55.104"
          "212.98.37.136"
        ];

        blocking = {
          blackLists.ads = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          ];
          clientGroupsBlock.default = [ "ads" ];
          blockType = "nxDomain";
        };
      };
    };
  };
}
