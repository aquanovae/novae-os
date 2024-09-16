{ flags }: { config, lib, pkgs, ... }:

let
  desktopFilesPath = /run/current-system/sw/share/applications;
in {

  config = lib.mkIf config.ricos.desktopEnvironment.enable {
    environment.systemPackages = [ (pkgs.writeShellScriptBin "quicklaunch" ''
      selection=$(
        pkill bemenu || \
          ls -1 ${desktopFilesPath} | \
          grep ".desktop" | \
          sed -e "s/\.desktop//" -e "s/.*\.//" | \
          tr "[:upper:]" "[:lower:]" | \
          sort | \
          bemenu -p "󱓞" ${flags}
      )

      desktopfile=$(
        ls -1 ${desktopFilesPath} | \
          grep -i $selection
      )

      dex "${desktopFilesPath}/$desktopfile"
    '') ];
  };
}
