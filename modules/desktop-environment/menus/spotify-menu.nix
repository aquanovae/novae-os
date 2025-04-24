{ flags }: { config, lib, pkgs, ... }: let

  cfg = config.novaeOs;

  spotifyMenu = pkgs.writeShellScriptBin "spotify-menu" /*bash*/ ''
    playlists=$(
      spotify-manager list-playlists
    )
    options=$(
      echo -e "$playlists\nremove"
    )
    destination=$(
      echo -e "$options" | \
        bemenu -p "󰓇" ${flags}
    )

    case $destination in
      "remove")
        spotify-manager switch-track -r;;
      *)
        spotify-manager switch-track $destination;;
    esac
  '';

in {

  config = lib.mkIf (cfg.desktopEnvironment.enable && cfg.programs.spotify.enable) {
    environment.systemPackages = [
      spotifyMenu
    ];
  };
}
