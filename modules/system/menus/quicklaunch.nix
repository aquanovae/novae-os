{ config, pkgs, ... }:

let
  flags = config.ricos.menus.bemenuFlags;

  desktopFilesPath = /run/current-system/sw/share/applications;
in {

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
}
