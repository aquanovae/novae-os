{ pkgs, ... }: {

  imports = [
    ./alacritty.nix
    ./nvim.nix
  ];

  environment.systemPackages = with pkgs; [
    devenv
    firefox
    gh
    git
    neofetch
    tree
  ];

  programs = {
    htop.enable = true;
  };
}
