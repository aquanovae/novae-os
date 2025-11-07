{ self, ... }: {

  flake.nixosModules = let
    callModule = path: { ... }: { imports = [ path ]; };
  in {

    novaeos = { ... }: {
      imports = with self.nixosModules; [
        novaeos-core
      ];
    };

    novaeos-core = callModule ./core;
  };
}
