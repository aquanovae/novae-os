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

  config = lib.mkIf config.novaeOs.desktopEnvironment.enable {
    # Enable graphics
    hardware.graphics.enable = true;

    services = {
      # Xserver has to be enabled even when using wayland
      # due to confusing name scheme
      xserver = {
        enable = true;
        videoDrivers = [
          "amdgpu"

        ] ++ lib.optionals config.novaeOs.hardware.nvidia.enable [
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

      # Audio setup
      pipewire = {
        enable = true;
        pulse.enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
      };
    };

    # Needed by pipewire
    security.rtkit.enable = true;

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
      firefox
      pamixer
      playerctl
      pwvucontrol
      radeontop
      swaybg
    ];

    programs = {
      hyprland.enable = true;
      xwayland.enable = true;
    };

    # Add jetbrains font
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    # Copy wallpaper to .config
    home-manager.users.${username} = {
      home = {
        file.".config/hypr/wallpaper.png"
          .source = ./wallpaper.png;

        pointerCursor = {
          package = pkgs.lyra-cursors;
          name = "LyraP-cursors";
          x11.enable = true;
          gtk.enable = true;
        };
      };

      gtk.enable = true;
    };
  };
}
