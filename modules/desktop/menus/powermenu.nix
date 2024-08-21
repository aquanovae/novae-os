{ config, lib, pkgs, ... }:

let
  menuOptions = [
    "󰤁 Poweroff"
    "󰔛 Timer"
    "󰤄 Suspend"
    "󰜉 Reboot"
    "󱑡 Reboot into firmware"
    "󰖳 Reboot into windows"
  ];

  timePresets = [
    "󰔟 3 minutes"
    "󰔟 10 minutes"
    "󰔟 30 minutes"
    "󰔟 1 houre"
    "󱫧 Cancel"
  ];

  flags = "${config.ricos.desktop.menus.bemenuFlags}";
in {

  environment.systemPackages = [ (pkgs.writeShellScriptBin "powermenu" ''
    function runMenu {
      case $(
        pkill bemenu || \
          echo "${lib.strings.concatStringsSep "\n" menuOptions}" | \
          bemenu -p "󰐥" ${flags}
      ) in
        "󰤁 Poweroff")
          systemctl poweroff;;
        "󰔛 Timer")
          setTimer;;
        "󰤄 Suspend")
          systemctl suspend;;
        "󰜉 Reboot")
          systemctl reboot;;
        "󱑡 Reboot into firmware")
          systemctl reboot --firmware-setup;;
        "󰖳 Reboot inot windows")
          grub-reboot 2 && systemctl reboot;;
        *)
          ;;
      esac
    }

    function setTimer {
      case $(
        pkill bemenu || \
          echo "${lib.strings.concatStringsSep "\n" timePresets}" | \
          bemenu -p "󰔛" ${flags}
      ) in
        "󰔟 3 minutes")
          shutdown 3;;
        "󰔟 10 minutes")
          shutdown 10;;
        "󰔟 30 minutes")
          shutdown 30;;
        "󰔟 1 houre")
          shutdown 60;;
        "󱫧 Cancel")
          shutdown -c;;
        *)
          ;;
      esac
    }

    runMenu
  '') ];
}
