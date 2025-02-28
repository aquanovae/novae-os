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
    hardware.graphics.enable = true;

    services = {
      # Xserver has to be enabled even when using wayland due to confusing name scheme
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        videoDrivers = [ "amdgpu" ];
      };

      displayManager.autoLogin = {
        enable = true;
        user = "${username}";
      };

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

    environment.systemPackages = with pkgs; [
      bemenu
      brightnessctl
      dex
      firefox
      pamixer
      playerctl
      pulseaudio
      pwvucontrol
      radeontop
      swaybg
    ];

    programs = {
      hyprland.enable = true;
      xwayland.enable = true;
    };

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    home-manager.users.${username} = {
      gtk.enable = true;
      home = {
        file.".config/hypr/wallpaper.png".source = ./wallpaper.png;

        pointerCursor = {
          package = pkgs.lyra-cursors;
          name = "LyraP-cursors";
          x11.enable = true;
          gtk.enable = true;
        };
      };
    };
  };
}
