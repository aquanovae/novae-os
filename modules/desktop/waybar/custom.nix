{ config, pkgs, ... }:

let
  theme = config.ricos.theme;

  gpu-info = pkgs.writeShellScriptBin "gpu-info" ''
    radeontop -b 3 -d - -l 1 | \
      grep -Eo "gpu [0-9]+\." | \
      sed -e "s/gpu //" -e "s/\./%/"
  '';

  shutdowntime = pkgs.writeShellScriptBin "shutdowntime" ''
    shutdown --show 2>&1 | grep -Eo "[0-9]{2}:[0-9]{2}"
  '';
in {

  environment.systemPackages = [
    gpu-info
    shutdowntime
  ];

  home-manager.users.rico.programs.waybar = {
    settings.bar = {
      "custom/os-icon" = {
        format = "󱄅";
        tooltip = false;
      };

      "custom/gpu-info" = {
        exec = "gpu-info";
        interval = 1;
        format = "{} 󰾲";
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

      #custom-gpu-info {
        background-color: #${theme.bg0};
        min-width: 65px;
      }

      #custom-shutdowntime {
        color: #${theme.bg0};
        background-color: #${theme.red};
        min-width: 75px;
      }
    '';
  };
}
