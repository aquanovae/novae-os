{ config, ... }: let
  hostname = config.networking.hostName;
in{

  services.syncthing = {
    openDefaultPorts = true;
  };

  home-manager.users.${config.novaeos.username}.services.syncthing = {
    enable = true;
    key = "${./${hostname}-key.pem}";
    cert = "${./${hostname}-cert.pem}";

    settings = {
      devices = {
        silverlight = { id = "UKUHLXG-LTLRUNQ-REAXDI2-YUINGNQ-LYIZOQZ-SUO22ZE-VBXTBY3-WQKSPA5"; };
        zenblade = { id = "726V62S-QEJUEFG-ROAQQ26-6JXFNIT-HCF3A6O-XX4FQVU-IOTWWCT-752Q4QF"; };
        minix = { id = "S7SZXV2-O76QG37-SBRFZBG-GJBSHHS-4354ZZV-LLBZZBG-3M55TML-CNTHWQD"; };
      };

      folders = let
        folder = {
          devices = [ "silverlight" "zenblade" "minix" ];
        };
      in {
        documents = folder // {
          path = "~/documents";
        };

        images = folder // {
          path = "~/images";
        };

        projects = folder // {
          path = "~/projects";
        };
      };
    };
  };
}
