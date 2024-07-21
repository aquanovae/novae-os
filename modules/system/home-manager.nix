{ inputs, ... }: {

  imports = [
    inputs.home-manager.nixosModules.default
  ];
  
  home-manager.users.rico.home = {
    username = "rico";
    homeDirectory = "/home/rico";

    stateVersion = "23.11";
  };
}
