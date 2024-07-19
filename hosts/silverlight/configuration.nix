{ inputs, pkgs, ... }: {

  imports = [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
  ];

  ricos.programs = {
    gaming.enable = true;
    openrgb.enable = true;
  };

  home-manager.users.rico = import ./../../modules/home/home.nix;

  programs = {
    coolercontrol.enable = true;
  };

  networking.hostName = "silverlight";

  services = {
    printing.enable = true;
  };

  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };
  programs.virt-manager.enable = true;

  system.stateVersion = "24.05";
}
