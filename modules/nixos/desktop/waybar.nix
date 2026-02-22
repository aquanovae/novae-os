{ inputs, self, ... }: {

  flake.nixosModules.waybar = { config, pkgs, ... }: with config.novaeos; {

    imports = with self.nixosModules; [
      waybarModules
      waybarStyle
    ];

    environment.systemPackages = with pkgs; [
      radeontop

      inputs.spotify-info.packages.${pkgs.system}.default
    ];

    home-manager.users.${username}.programs.waybar = {
      enable = true;

      settings.bar = {
        layer = "top";
        position = "top";
        margin = "3px 3px 0px";
        spacing = 7;
        reload_style_on_change = true;

        modules-left = [
          "custom/os-icon"
          "hyprland/workspaces"
        ];
      };
    };
  };


  flake.nixosModules.waybarTowerModules = { config, ... }: with config.novaeos; {

    home-manager.users.${username}.programs.waybar.settings.bar = {
      modules-center = [
        "custom/spotify-info"
      ];
      modules-right = [
        "custom/shutdowntime"
        "disk"
        "memory"
        "cpu"
        "custom/gpu-info"
        "clock"
      ];
    };
  };


  flake.nixosModules.waybarLaptopModules = { config, ... }: with config.novaeos; {

    home-manager.users.${username}.programs.waybar.settings.bar = {
      modules-center = [
        "custom/spotify-info"
      ];
      modules-right = [
        "custom/shutdowntime"
        "wireplumber"
        "disk"
        "memory"
        "cpu"
        "battery"
        "clock"
      ];
    };
  };
}
