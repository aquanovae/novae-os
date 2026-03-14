{ self, ... }: {

  flake.nixosModules.desktop = { pkgs, ... }: {

    imports = with self.nixosModules; [
      audio
      home
      hyprland
      plymouth
    ];

    hardware.graphics.enable = true;

    services.xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
    };

    services.displayManager = {
      gdm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "aquanovae";
    };
    systemd.services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };

    services.logind.settings.Login = {
      HandlePowerKey = "ignore";
      HandleLidSwitch = "ignore";
    };

    fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

    home-manager.users.aquanovae = {
      gtk.enable = true;
      home.pointerCursor = {
        package = pkgs.lyra-cursors;
        name = "LyraP-cursors";
        x11.enable = true;
        gtk.enable = true;
      };
    };
  };
}
