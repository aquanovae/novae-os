{ ... }: {

  imports = [
    ./alacritty.nix
    ./bindings.nix
    ./hyprland.nix
    ./nvim.nix
    ./starship.nix
    ./waybar/waybar.nix
    ./zsh.nix
  ];

  home = {
    username = "rico";
    homeDirectory = "/home/rico";

    stateVersion = "23.11";
  };
}
