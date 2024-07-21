{ pkgs, ... }: {

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
    swaybg
  ];

  programs.xwayland.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" ];
    })
  ];
}
