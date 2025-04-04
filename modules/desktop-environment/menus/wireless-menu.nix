{ flags }: { config, lib, pkgs, ... }: let

  desktopEnvironment = config.novaeOs.desktopEnvironment;
  wireless = config.novaeOs.hardware.wireless;

  menuOptions = lib.concatStringsSep "\n" [
    "󱛃 Connect"
    "󱛃 Connect hidden"
    "󱛂 Disconnect"
    "󱛅 Forget"
  ];

  station = "station wlan0";

  wirelessMenuScript = pkgs.writeShellScriptBin "wireless-menu" /*bash*/ ''
    function run_menu {
      iwctl ${station} scan

      connected=$(
        iwctl ${station} show | \
          grep "Connected network"
      )
      options="${menuOptions}\n$connected"
      selected=$(
        echo -e "$options" | \
          bemenu -p 󰖩 ${flags} --width-factor 0.4
      )

      case $selected in
        "󱛃 Connect")
          connect_menu;;
        "󱛃 Connect hidden")
          connect_hidden_menu;;
        "󱛂 Disconnect")
          iwctl ${station} disconnect;;
        "󱛅 Forget")
          forget_menu;;
      esac
    }

    function connect_menu {
      iwctl ${station} scan

      networklist=$(
        iwctl ${station} get-networks | \
          grep "*" | \
          sed \
            -e "s/>/󱚽/" \
            -e "s/\x1b\[1;90m\**//" \
            -e "s/\x1b\[[0-9;]*m//g" \
            -e "s/\*\{4\}/󰤨/" \
            -e "s/\*\{3\}/󰤥/" \
            -e "s/\*\{2\}/󰤢/" \
            -e "s/\*\{1\}/󰤟/" \
      )

      options="󱛄 Refresh\nAvailable networks:\n$networklist"

      selected=$(
        echo -e "$options" | \
          bemenu -p 󰖩 ${flags} --width-factor 0.4
      )

      case $selected in
        "󱛄 Refresh")
          connect_menu;;
        *)
          [[ -n $selected ]] && connect "$selected" 0;;
      esac
    }

    function connect_hidden_menu {
      network_name=$(
        echo "" | \
          bemenu -p "name:" ${flags} --prefix "" --list 0
      )

      connect "$network_name" 1
    }

    function connect {
      network_name=$(
        echo "$1" | \
          sed -e "s/󱚽//" -e "s/\s\+//" -e "s/\s\{2,\}.*//"
      )

      connect="connect"

      if [[ $2 -ne 0 ]]; then
        connect="connect-hidden"
      fi

      timeout 2 \
        iwctl ${station} $connect "$network_name" --dont-ask

      pkill iwctl

      if [[ $? -ne 0 ]]; then
        password=$(
          prompt_password_menu
        )

        timeout 2 \
          iwctl ${station} $connect "$network_name" --passphrase "$password"

        pkill iwctl
      fi
    }

    function prompt_password_menu {
      password=$(
        echo "" | \
          bemenu -p "password:" ${flags} --password indicator --prefix "" --list 0
      )

      echo "$password"
    }

    function forget_menu {
      known_networks=$(
        iwctl known-networks list | \
          grep "[0-9]:[0-9]" | \
          sed -e "s/\s\+//" -e "s/\s\{2,\}.*//" -e "s/\x1b\[[0-9;]*m//g"
      )

      selected=$(
        echo "$known_networks" | \
          bemenu -p 󱛅 ${flags} --width-factor 0.4
      )

      iwctl known-networks "$selected" forget
    }

    run_menu
  '';

  desktopFile = pkgs.makeDesktopItem {
    name = "wireless-menu";
    desktopName = "wireless-menu";
    type = "Application";
    exec = "${wirelessMenuScript}/bin/wireless-menu";
    terminal = false;
  };

in {

  config = lib.mkIf (desktopEnvironment.enable && wireless.enable) {
    environment.systemPackages = [
      desktopFile
      wirelessMenuScript
    ];
  };
}
