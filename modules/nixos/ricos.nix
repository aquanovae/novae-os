{ ... }: {

  imports = [
    ./core/core.nix
    ./core/desktop.nix
    ./core/silent-boot.nix

    ./programs/base.nix
    ./programs/gaming.nix
    ./programs/openrgb.nix
  ];
}
