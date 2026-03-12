{ inputs, ... }: {

  flake.nixosModules.home = { ... }: {

    imports = [ inputs.home-manager.nixosModules.default ];

    home-manager.users.aquanovae.home = {
      username = "aquanovae";
      homeDirectory = "/home/aquanovae";
      stateVersion = "24.05";
    };

    home-manager.users.aquanovae.programs.zsh.enable = true;
  };
}
