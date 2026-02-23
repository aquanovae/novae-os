{ ... }: {

  flake.nixosModules.plymouth = { pkgs, ... }: {

    boot.kernelModules = [ "amdgpu" ];
    boot.plymouth = {
      enable = true;
      theme = "nixos-bgrt";
      themePackages = [ pkgs.nixos-bgrt-plymouth ];
    };
  };
}
