{ ... }: {

  imports = [
    ./boot.nix
    ./neovim.nix
    ./packages.nix
    ./starship.nix
    ./theme.nix
    ./user.nix
    ./zsh.nix
  ];
}
