{ self, ... }: {

  flake.nixosModules.desktop = { config, pkgs, ... }: with config.novaeos; {

    imports = with self.nixosModules; [
      hyprland
      waybar
    ];

    hardware.graphics.enable = true;

    services.xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
    };

    services.displayManager = {
      gdm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "${username}";
    };
    systemd.services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };

    services.logind.settings.Login = {
      HandlePowerKey = "ignore";
      HandleLidSwitch = "ignore";
    };

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };

    fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

    home-manager.users.${username} = {
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
