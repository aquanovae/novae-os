{ config, pkgs, ... }:

let
  runMenu = "bemenu --prompt '󱓞' ${config.ricos.desktop.menus.bemenuFlags}";

  desktopFilesPath = /run/current-system/sw/share/applications;

  quicklaunch = pkgs.writeShellScriptBin "quicklaunch" ''
    selection=$(
      ls -1 ${desktopFilesPath} | \
        grep ".desktop" | \
        sed -e "s/\.desktop//" -e "s/.*\.//" | \
        tr "[:upper:]" "[:lower:]" | \
        ${runMenu}
    )

    desktopfile=$(
      ls -1 ${desktopFilesPath} | \
        grep -i $selection
    )

    dex "${desktopFilesPath}/$desktopfile"
  '';
in {

  environment.systemPackages = [ quicklaunch ];
}
