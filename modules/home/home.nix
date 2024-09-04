{ ... }: {

  imports = [
    ./alacritty.nix
    ./nvim.nix
  ];

  home = {
    username = "rico";
    homeDirectory = "/home/rico";

    stateVersion = "23.11";
  };
}
