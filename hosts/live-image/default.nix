{ inputs, lib, modulesPath, pkgs, username, ... }: {

  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages;
    loader = {
      timeout = lib.mkForce 10;
      grub.enable = lib.mkForce true;
    };
  };

  home-manager.users.${username}.home.file = {
    "ricos".source = inputs.ricos;
  };
}
