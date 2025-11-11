{ username, ... }: {

  imports = [
  ];

  home-manager.users.${username}.home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };

}
