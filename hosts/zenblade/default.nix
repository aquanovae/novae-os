{ ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  ricos = {
    desktopEnvironment = {
      enable = true;
      waybar.modules = "laptop";
    };

    hardware = {
      #nvidia.enable = true;
      wireless.enable = true;
    };

    programs = {
      defaultDesktopApps.enable = true;
      imageEditingApps.enable = true;
      virtualisationApps.enable = true;
      vscode.enable = true;
    };
  };

  system.stateVersion = "23.11";
}

