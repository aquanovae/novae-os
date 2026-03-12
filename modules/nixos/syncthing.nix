{ ... }: {

  flake.nixosModules.syncthing = { ... }: {

    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      user = "aquanovae";
      group = "users";
      dataDir = "/home/aquanovae";
    };

    services.syncthing.settings = {
      devices = {
        minix       = { id = "T3XODJT-G2M6DBY-MUAWXK6-MF3OEUX-A7T3KUA-TETKBSU-RCTPAXS-22EGNAC"; };
        silverlight = { id = "DD6KA6S-2DT7NGY-GJZFCEI-MZP7PQX-KBCDTXM-6XEAGKM-RSEUQO6-CXWMUAW"; };
        zenblade    = { id = "E6WVNQ2-VBIOLUC-IJRBDGY-TSEJWFQ-FAHAKG6-6Q37B65-PTUVJUO-GQP6VQY"; };
      };

      folders.files = {
        path = "/home/aquanovae/files";
        devices = [ "minix" "silverlight" "zenblade" ];
      };
    };
  };
}
