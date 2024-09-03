{ ... }: {

  imports = [
    ./desktop.nix
    ./openrgb.nix
    ./menus/menus.nix
    ./nvidia.nix
    ./silent-boot.nix
    ./theme/theme.nix
  ];
}
