{ self, inputs, ... }: {

  flake.nixosModules.launcher = { config, ... }: with config; {

    imports = with self.nixosModules; [
      powermenu

      inputs.otter-launcher.nixosModules.default
    ];

    programs.otter-launcher.enable = true;
    programs.otter-launcher.settingsExtra = /*toml*/ ''

      [general]
      exec_cmd = "zsh -c"
      vi_mode = true

      [interface]
      header = "\u001B[34m > \u001B[0m"
      place_holder = ""
      suggestion_lines = 5
      list_prefix = "   "
      prefix_color = "\u001B[35m"
      prefix_padding = 3
      description_color = "\u001B[90m"
      indicator_with_arg_module = "$"
    '';

    home-manager.users.aquanovae.programs.fzf = {
      enable = true;
      enableZshIntegration = true;

      defaultOptions = [
        "--reverse"
        "--gutter=' '"
        "--pointer=' '"
        "--no-info"
        "--no-separator"
      ];

      colors = {
        fg = "#${theme.fg}";
        bg = "#${theme.bg0}";
        hl = "#${theme.magenta}";
        "fg+" = "#${theme.blue}";
        "bg+" = "#${theme.bg0}";
        "hl+" = "#${theme.magenta}";
        prompt = "#${theme.blue}";
      };
    };
  };

  flake.nixosModules.powermenu = { lib, pkgs, ... }: let
    
    menuOptions = lib.concatStringsSep "\n" [
      " Poweroff"
      " Suspend"
      " Reboot"
      " Firmware"
    ];

    powermenu = pkgs.writeShellScript "powermenu" ''
      case $(echo -e "${menuOptions}" | fzf --prompt " > ") in
        " Poweroff") systemctl poweroff;;
        " Suspend") (sleep 1 && systemctl suspend) & hyprlock -q;;
        " Reboot") systemctl reboot;;
        " Firmware") systemctl reboot --firmware-setup;;
        *) ;;
      esac
    '';

  in {

    programs.otter-launcher.settingsExtra = /*toml*/ ''
      
      [[modules]]
      description = "powermenu"
      prefix = "pw"
      cmd = "${powermenu}"

      [[modules]]
      description = "shutdown timer"
      prefix = "sd"
      with_argument = true
      cmd = "shutdown {}"
    '';
  };
}
