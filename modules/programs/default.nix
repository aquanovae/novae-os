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
    lutris
    neofetch
    prismlauncher
    spotify
    tree
  ];

  programs = {
    htop.enable = true;
    steam.enable = true;
  };
}
