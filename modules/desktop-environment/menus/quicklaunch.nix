# ------------------------------------------------------------------------------
# Program launcher script
# ------------------------------------------------------------------------------
{ flags }: { config, lib, pkgs, ... }:

let
  desktopFilesPath = /run/current-system/sw/share/applications;

  quicklaunchScript = pkgs.writeShellScriptBin "quicklaunch" ''
    # Run formated desktop files list through bemenu
    selection=$(
      ls -1 ${desktopFilesPath} | \
        grep ".desktop" | \
        sed -e "s/\.desktop//" -e "s/.*\.//" | \
        tr "[:upper:]" "[:lower:]" | \
        sort | \
        bemenu -p "󱓞" ${flags}
    )

    # Get desktop file name from selection
    desktopfile=$(
      ls -1 ${desktopFilesPath} | \
        grep -i $selection | \
        sed 1q
    )

    # Run selected program
    dex "${desktopFilesPath}/$desktopfile"
  '';
in {

  config = lib.mkIf config.ricos.desktopEnvironment.enable {
    environment.systemPackages = [
      quicklaunchScript
    ];
  };
}
