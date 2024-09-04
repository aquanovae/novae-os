{ inputs, username, ... }: {

  imports = [
    ./core
    ./desktop-environment
    ./programs

    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.users.${username}.home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    stateVersion = "23.11";
  };
}
