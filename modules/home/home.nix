{ ... }: {

  imports = [
    ./theme/theme.nix

    ./alacritty.nix
    ./hyprland.nix
    ./nvim/nvim.nix
    ./starship.nix
    ./waybar/waybar.nix
    ./../zsh.nix
  ];

  home = {
    username = "rico";
    homeDirectory = "/home/rico";

    stateVersion = "23.11";
  };
}
