{ inputs, self, ... }: {

  flake.nixosConfigurations = with inputs.nixpkgs.lib; let
    novaeos = self.nixosModules.novaeos;
    novaepkgs = let
      callNovaePackage = package: inputs.${package}.packages.x86_64-linux.default;
    in{
      spotify-daily = callNovaePackage "spotify-daily";
      spotify-info = callNovaePackage "spotify-info";
    };
    callConfiguration = path: nixosSystem {
      specialArgs = { inherit inputs novaepkgs; username = "aquanovae"; };
      modules = [ path novaeos ./../modules-bak-bak ];
    };
  in {
    silverlight = callConfiguration ./silverlight;
    #zenblade = callConfiguration ./zenblade;
    minix = callConfiguration ./minix;
    live-image = callConfiguration ./live-image;
  };
}
