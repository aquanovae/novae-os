{ config, extraPkgs, lib, ... }: {

  config = lib.mkIf config.novaeOs.server.enable {

    environment.systemPackages = [
      extraPkgs.daily-playlist
    ];

    systemd = {
      timers.daily-playlist = {
        enable = true;
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "*-*-* 04:00:00";
          Unit = "daily-playlist.service";
        };
      };

      services.daily-playlist = {
        path = [ extraPkgs.daily-playlist ];
        script = ''
          daily-playlist generate
        '';
      };
    };
  };
}
