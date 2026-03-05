{ inputs, ... }: {

  flake.nixosModules.dailyPlaylist = { pkgs, ... }: let
    
    spotify-daily = inputs.spotify-daily.${pkgs.stdenv.hostPlaform.system}.default;

  in {

    systemd.timers.daily-playlist = {
      enable = true;
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 04:00:00";
        Unit = "daily-playlist.service";
      };
    };

    systemd.services.daily-playlist = {
      path = [ spotify-daily ];
      script = "spotify-daily";
    };

    environment.systemPackages = [ spotify-daily ];
  };
}
