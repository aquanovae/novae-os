{ hostname, lib, pkgs, ... }: {

  imports = [
    ./nvim.nix
    ./starship.nix
    ./zsh.nix

  ] ++ lib.optionals (hostname == "silverlight") [
    ./alacritty.nix
    ./coolercontrol.nix
    ./firefox.nix
    ./gaming.nix
    ./image-editor.nix
    ./openrgb.nix
    ./spotify.nix
    ./virtual-machine.nix

  ] ++ lib.optionals (hostname == "zenblade") [
    ./alacritty.nix
    ./firefox.nix
    ./image-editor.nix
    ./spotify.nix
  ];

  environment.systemPackages = with pkgs; [
    devenv
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
