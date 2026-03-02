{ ... }: {

  flake.nixosModules.ranger = { ... }: {
  
    home-manager.users.aquanovae.programs.ranger = {
      enable = true;

      rifle = [{
        condition = "ext x?pdf?";
        command = "firefox \"$@\" &";
      }];
    };
  };
}
