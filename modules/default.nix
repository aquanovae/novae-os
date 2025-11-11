{ inputs, self, ... }: {

  flake.nixosModules = let
    callModule = path: { ... }: { imports = [ path ]; };
  in {

    novaeos = { ... }: {
      imports = with self.nixosModules; [
        novaeos-core
        inputs.nixvim.nixosModules.nixvim
      ];
    };

    novaeos-core = callModule ./core;
  };
}
