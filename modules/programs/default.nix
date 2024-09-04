{ pkgs, ... }: {

  imports = [
    ./alacritty.nix
    ./openrgb.nix
    ./nvim.nix
  ];

  environment.systemPackages = with pkgs; [
    devenv
    firefox
    gh
    gimp
    git
    grub2_efi
    inkscape
    neofetch
    spotify
    tree
  ];

  programs = {
    htop.enable = true;
  };
}
