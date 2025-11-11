{ ... }: {

  imports = [
    ./boot.nix
    ./locale.nix
    ./neovim.nix
    ./packages.nix
    ./starship.nix
    ./theme.nix
    ./user.nix
    ./zsh.nix
  ];
}
