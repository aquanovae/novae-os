{ modulesPath, lib, pkgs, ... }: {

  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages;
    loader.timeout = lib.mkForce 10;
  };
}
