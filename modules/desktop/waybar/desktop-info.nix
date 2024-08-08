{ config, ... }:

let
  theme = config.ricos.theme;
in {

  home-manager.users.rico.programs.waybar = {
    settings.bar = {
      "hyprland/workspaces" = {
        format = "{id} {windows}";
        window-rewrite-default = "󰘔";
        window-rewrite = {
          alacritty = "󰆍";
          coolercontrol = "󰄪";
          firefox = "󰈹";
          spotify = "󰓇";
          "title<steam>" = "󰓓";
        };
        tooltip = false;
      };

      "hyprland/submap" = {
        format = "{}";
        tooltip = false;
      };
    };

    style = /*css*/ ''
      #workspaces {
        border-radius: 5px;
        background-color: #${theme.bg0};
      }

      #workspaces button {
        margin: 0px;
        padding: 0px 8px;
      }

      #workspaces button label {
        font-size: 19px;
        color: #${theme.fg};
      }

      #workspaces button.active label {
        color: #${theme.blue};
      }

      #workspaces button:hover {
        background-color: #${theme.blue};
      }

      #workspaces button:hover label {
        color: #${theme.bg0};
      }

      #submap {
        padding: 0px 5px;
        color: #${theme.red};
        background-color: #${theme.bg0};
      }
    '';
  };
}
