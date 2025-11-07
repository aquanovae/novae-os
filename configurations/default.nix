{ inputs, self, ... }: {

  flake.nixosConfigurations = let
    novaeos = self.nixosModules.novaeos;
    nixosSystem = inputs.nixpkgs.lib.nixosSystem;
    extraPkgs = {
      spotify-daily = inputs.spotify-daily.packages.x86_64-linux.default;
    };
    specialArgs = { 
      inherit inputs extraPkgs;
      username = "aquanovae";
    };
  in {

    silverlight = nixosSystem {
      inherit specialArgs;
      modules = [
        novaeos
        ./silverlight
        ./../modules-bak
      ];
    };

    zenblade = nixosSystem {
      inherit specialArgs;
      modules = [
        novaeos
        ./zenblade
        ./../modules-bak
      ];
    };

    minix = nixosSystem {
      inherit specialArgs;
      modules = [
        novaeos
        ./minix
        ./../modules-bak
      ];
    };

    live-image = nixosSystem {
      inherit specialArgs;
      modules = [
        novaeos
        ./live-image
        ./../modules-bak
      ];
    };
  };
}
