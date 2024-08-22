{ inputs, ... }: {

  imports = [
    ./desktop/desktop.nix
    ./programs/programs.nix
    ./system/system.nix

    inputs.home-manager.nixosModules.default
  ];

  home-manager.users.rico = import ./home/home.nix;
}
