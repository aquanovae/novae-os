{ hostname, inputs, lib, ... }: {

  imports = [
    ./core
    ./desktop-environment
    ./programs
    inputs.home-manager.nixosModules.home-manager

  ] ++ lib.optionals (hostname == "minix-server") [
    ./server
  ];

  options.ricos = {
    desktopEnvironment = {
      enable = lib.mkEnableOption "desktop environment";
      waybar.modules = lib.mkOption {
        type = lib.types.enum [ "desktop" "laptop" "minimal" ];
      };
    };

    hardware = {
      nvidia.enable = lib.mkEnableOption "nvidia config";
      wireless.enable = lib.mkEnableOption "wireless config";
    };

    programs = {
      coolercontrol.enable = lib.mkEnableOption "coolercontrol";
      defaultDesktopApps.enable = lib.mkEnableOption "default desktop apps";
      gamingApps.enable = lib.mkEnableOption "gaming apps";
      imageEditingApps.enable = lib.mkEnableOption "image editing apps";
      openrgb.enable = lib.mkEnableOption "openrgb";
      virtualisationApps.enable = lib.mkEnableOption "virtualisation apps";
    };

    server = {
      ssh.enable = lib.mkEnableOption "ssh config";
    };
  };
}
