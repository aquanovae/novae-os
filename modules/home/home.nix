{ ... }: {

  imports = [
    ./alacritty.nix
    ./nvim.nix
    ./waybar/waybar.nix
  ];

  home = {
    username = "rico";
    homeDirectory = "/home/rico";

    stateVersion = "23.11";
  };
}
