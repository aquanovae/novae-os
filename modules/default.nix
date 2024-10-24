{ inputs, lib, ... }: {

  imports = [
    ./core
    ./desktop-environment
    ./hardware
    ./programs
    ./server
    ./virtual-machine

    inputs.home-manager.nixosModules.home-manager
  ];

  options.ricos = with lib; {
    desktopEnvironment = {
      enable = mkEnableOption "desktop environment";
      waybar.modules = mkOption {
        type = types.enum [ "desktop" "laptop" "minimal" ];
      };
    };

    hardware = {
      nvidia.enable = mkEnableOption "nvidia config";
      wireless.enable = mkEnableOption "wireless config";
    };

    programs = {
      coolercontrol.enable = mkEnableOption "coolercontrol";
      defaultDesktopApps.enable = mkEnableOption "default desktop apps";
      gamingApps.enable = mkEnableOption "gaming apps";
      imageEditingApps.enable = mkEnableOption "image editing apps";
      openrgb.enable = mkEnableOption "openrgb";
      vscode.enable = mkEnableOption "visual studio code";
    };

    server.enable = mkEnableOption "server configs";

    virtualMachine = {
      enable = mkEnableOption "virtual machine";
      coreCount = mkOption {
        type = types.str;
      };
      memory = mkOption {
        type = types.str;
      };
      gpuPassthrough = {
        enable = mkEnableOption "enable gpu passthrough for virtual machine";
        gpuId = mkOption {
          type = types.str;
        };
        gpuPciId = mkOption {
          type = types.str;
        };
        fakeBattery.enable = mkEnableOption "fake battery for virtual machine";
      };
    };
  };
}
