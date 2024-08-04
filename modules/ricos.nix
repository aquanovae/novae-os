{ ... }: {

  imports = [
    ./system/system.nix
    ./system/home-manager.nix
    ./system/silent-boot.nix
    ./system/prompt/zsh.nix
    ./system/prompt/starship.nix
    ./system/editor/nvim.nix
    ./system/theme/theme.nix

    ./desktop/desktop.nix
    ./desktop/hyprland.nix
    ./desktop/bindings.nix
    ./desktop/bemenu.nix
    ./desktop/bar/waybar.nix
    ./desktop/bar/bar-modules.nix
    ./desktop/bar/style.nix

    ./programs/programs.nix
    ./programs/alacritty.nix
    ./programs/openrgb.nix
    ./programs/gaming.nix
  ];
}
