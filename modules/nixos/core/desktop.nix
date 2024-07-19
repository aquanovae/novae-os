{ config, lib, pkgs, ... }:

let
  cfg = config.ricos.desktop;
in {

  options.ricos.desktop = {
    enable = lib.mkEnableOption "enable desktop";
  };

  config = lib.mkIf cfg.enable {
    hardware = {
      graphics.enable = true;
    };

    systemd.services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };

    services = {
      xserver = {
        enable = true;
        videoDrivers = [ "amdgpu" ];
        displayManager.gdm.enable = true;
      };

      displayManager.autoLogin = {
        enable = true;
        user = "rico";
      };
    };

    environment.systemPackages = with pkgs; [
      bemenu
      starship
      swaybg
    ];

    programs = {
      hyprland.enable = true;
      waybar.enable = true;
      xwayland.enable = true;
    };

    fonts.packages = with pkgs; [
      (nerdfonts.overrids {
        fonts = [ "JetBrainsMono" ];
      })
    ];
  };
}
