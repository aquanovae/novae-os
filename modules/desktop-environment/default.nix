{ config, extraPkgs, lib, pkgs, username, ... }: {

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
      xserver = {
        enable = true;
        videoDrivers = [ "amdgpu" ];
      };

      displayManager = {
        gdm.enable = true;
        autoLogin = {
          enable = true;
          user = "${username}";
        };
      };

      logind.settings.Login = {
        HandlePowerKey = "ignore";
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
      extraPkgs.zen-browser
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

    fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

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
