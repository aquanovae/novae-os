{ config, pkgs, ... }:

let
  theme = config.ricos.theme;
in {

  home-manager.users.rico.programs.waybar = {
    settings.bar = {
      "custom/os-icon" = {
        format = "󱄅";
        tooltip = false;
      };

      "custom/shutdowntime" = {
        exec = "shutdowntime";
        interval = 1;
        format = "{} 󱫌";
      };
    };

    style = /*css*/ ''
      #custom-os-icon {
        font-size: 23px;
        padding: 0px 13px 0px 7px;
        border-radius: 5px;
        color: #${theme.bg0};
        background-color: #${theme.blue};
      }

      #custom-shutdowntime {
        color: #${theme.bg0};
        background-color: #${theme.red};
        min-width: 75px;
      }
    '';
  };

  environment.systemPackages =
  let
    shutdowntime = pkgs.writeShellScriptBin "shutdowntime" ''
      shutdown --show 2>&1 | \
        grep -Eo "[0-9]{2}:[0-9]{2}"
    '';
  in [ shutdowntime ];
}
