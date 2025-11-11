{ ... }: {

  imports = [
    ./boot.nix
    ./neovim.nix
    ./packages.nix
    ./starship.nix
    ./user.nix
    ./zsh.nix
  ];
}
