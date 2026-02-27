{ ... }: {

  flake.nixosModules.powermenu = { lib, pkgs, ... }: let
    
    menuOptions = lib.concatStringsSep "\n" [
      "󰤁 Poweroff"
      "󰤄 Suspend"
      "󰜉 Reboot"
      "󱑡 Firmware"
    ];

    powermenu = pkgs.writeShellScript "powermenu" ''
      case $(echo -e "${menuOptions}" | fzf) in
        "󰤁 Poweroff") systemctl poweroff;;
        "󰤄 Suspend") (sleep 1 && systemctl suspend) & hyprlock -q;;
        "󰜉 Reboot") systemctl reboot;;
        "󱑡 Firmware") systemctl reboot --firmware-setup;;
        *) ;;
      esac
    '';

  in {

    programs.otter-launcher.settingsExtra = /*toml*/ ''
      
      [[modules]]
      description = "powermenu"
      prefix = "pw"
      cmd = "${powermenu}"
      cmd = "${powermenu}"

      [[modules]]
      description = "shutdown timer"
      prefix = "sd"
      with_argument = true
      cmd = "shutdown {}"
    '';
  };
}
