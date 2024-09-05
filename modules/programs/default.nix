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
    grub2_efi
    neofetch
    tree
  ];

  programs = {
    htop.enable = true;
  };
}
