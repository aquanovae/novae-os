{ flags }: { config, lib, pkgs, ... }: let

  desktopFilesPath = /run/current-system/sw/share/applications;

  blacklistedEntries = "-e " + lib.strings.concatStringsSep " -e " [
    "code-url-handler"
    "coolercontrol"
    "htop"
    "nixos-manual"
    "xdg-desktop-portal"
    "xterm"
    "xwayland"
  ];

  quicklaunchScript = pkgs.writeShellScriptBin "quicklaunch" /*bash*/ ''
    full_list=$(
      ls -1 ${desktopFilesPath} | \
        grep ".desktop" | \
        sed -e "s/\.desktop//" -e "s/.*\.//" | \
        tr "[:upper:]" "[:lower:]" | \
        sort
    )

    filtered_list=$(
      echo "$full_list" | \
        grep -v ${blacklistedEntries}
    )

    selection=$(
      echo "$filtered_list" | \
        bemenu -p "󱓞" ${flags}
    )

    desktopfile=$(
      ls -1 ${desktopFilesPath} | \
        grep -i $selection | \
        sed 1q
    )

    dex "${desktopFilesPath}/$desktopfile"
  '';

in {

  config = lib.mkIf config.novaeOs.desktopEnvironment.enable {
    environment.systemPackages = [ quicklaunchScript ];
  };
}
