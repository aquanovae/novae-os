# ------------------------------------------------------------------------------
# Desktop environment configuration
# ------------------------------------------------------------------------------
{ config, lib, pkgs, username, ... }: {

  imports = [
    ./bindings.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./launch-scripts.nix
    ./menus
    ./waybar
  ];

  config = lib.mkIf config.ricos.desktopEnvironment.enable {
    # Enable graphics
    hardware.graphics.enable = true;

    services = {
      # Xserver has to be enabled even when using wayland
      # due to confusing name scheme
      xserver = {
        enable = true;
        videoDrivers = [
          "amdgpu"

        ] ++ lib.optionals config.ricos.hardware.nvidia.enable [
          "nvidia"
        ];

        # Enable display manager
        displayManager.gdm.enable = true;
      };

      # Setup auto login
      displayManager.autoLogin = {
        enable = true;
        user = "${username}";
      };
    };

    # Fix black screen on boot when auto login is enabled
    systemd.services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };

    # Required programs for desktop environment
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

    # Copy wallpaper to .config
    home-manager.users.${username}.home = {
      file.".config/hypr/wallpaper.png".source = ./wallpaper.png;
    };
  };
}
