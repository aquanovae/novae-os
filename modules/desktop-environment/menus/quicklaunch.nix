{ flags }: { config, lib, pkgs, ... }: let

  desktopFilesPath = /run/current-system/sw/share/applications;

  grepBlacklistedEntries = "-e " + lib.strings.concatStringsSep " -e " [
    "htop"
    "nixos-manual"
    "xdg-desktop-portal"
    "xterm"
    "xwayland"
  ];

  quicklaunchScript = pkgs.writeShellScriptBin "quicklaunch" ''
    # Get list of desktop files
    full_list=$(
      ls -1 ${desktopFilesPath} | \
        grep ".desktop" | \
        sed -e "s/\.desktop//" -e "s/.*\.//" | \
        tr "[:upper:]" "[:lower:]" | \
        sort
    )

    # Filter blacklisted entries
    list=$(
      echo "$full_list" | \
        grep -v ${grepBlacklistedEntries}
    )

    # Run desktop files list through bemenu
    selection=$(
      echo "$list" | \
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

  config = lib.mkIf config.novaeOs.desktopEnvironment.enable {
    environment.systemPackages = [
      quicklaunchScript
    ];
  };
}
