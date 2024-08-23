{ pkgs, ... }: {

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
      user = "rico";
    };
  };

  environment.systemPackages = [ pkgs.swaybg ];

  programs.xwayland.enable = true;

  # Fix for autologin
  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };
}
