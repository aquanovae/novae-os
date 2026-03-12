{ inputs, self, ... }: {

  flake.nixosConfigurations.live-image = inputs.nixpkgs.lib.nixosSystem {

    modules = with self.nixosModules; [
      live-image

      core
      desktop
      programsMinimal
      waybarLiveImage
      wireless
    ];
  };

  flake.nixosModules.live-image = { lib, modulesPath, pkgs, ... }: {

    imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];

    networking.hostName = "live-image";

    boot.kernelPackages = lib.mkForce pkgs.linuxPackages;
    boot.loader = {
      timeout = lib.mkForce 10;
      grub.enable = lib.mkForce false;
    };

    fonts.fontconfig.enable = true;

    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
