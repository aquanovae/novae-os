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
        minix =     { id = "T3XODJT-G2M6DBY-MUAWXK6-MF3OEUX-A7T3KUA-TETKBSU-RCTPAXS-22EGNAC"; };
        zenblade =  { id = "E6WVNQ2-VBIOLUC-IJRBDGY-TSEJWFQ-FAHAKG6-6Q37B65-PTUVJUO-GQP6VQY"; };
      };

      folders = {
        documents = {
          path = "/home/aquanovae/documents";
          devices = [ "minix" "zenblade" ];
        };

        images = {
          path = "/home/aquanovae/images";
          devices = [ "minix" "zenblade" ];
        };

        projects = {
          path = "/home/aquanovae/projects";
          devices = [ "minix" "zenblade" ];
        };
      };
    };
  };
}
