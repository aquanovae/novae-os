{ pkgs, username, ... }: {

  imports = [
    ./bindings.nix
    ./hyprland.nix
    ./menus
    ./waybar
  ];

  hardware = {
    graphics.enable = true;
  };

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

  environment.systemPackages = with pkgs; [
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

  # Fix for autologin
  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };
}
