{ config, lib, pkgs, username, ... }: {

  imports = [
    ./bindings.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./menus
    ./waybar
  ];

  config = lib.mkIf config.ricos.desktopEnvironment.enable {
    hardware.opengl.enable = true;

    services = {
      xserver = {
        enable = true;
        videoDrivers = [ "amdgpu" ];
        displayManager.gdm.enable = true;
      };

      displayManager.autoLogin = {
        enable = true;
        user = "${username}";
      };
    };

    # Fix for autologin
    systemd.services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };

    environment.systemPackages = with pkgs; [
      bemenu
      brightnessctl
      dex
      pamixer
      playerctl
      radeontop
      swaybg
    ];

    programs = {
      hyprland.enable = true;
      xwayland.enable = true;
    };

    home-manager.users.${username}.home = {
      file.".config/hypr/wallpaper.png".source = ./wallpaper.png;
    };
  };
}
