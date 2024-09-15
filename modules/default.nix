{ hostname, inputs, lib, username, ... }: {

  imports = [
    ./core
    ./programs
    inputs.home-manager.nixosModules.home-manager

  ] ++ lib.optionals (hostname != "minix-server") [
    ./desktop-environment

  ] ++ lib.optionals (hostname == "minix-server") [
    ./server
  ];

  home-manager.users.${username}.home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    stateVersion = "24.05";
  };
}
