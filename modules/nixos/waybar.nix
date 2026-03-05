{ inputs, self, ... }: let

  mkSpan = icon: color: "<span color='#${color}' size='11pt'>${icon}</span>";

in {

  flake.nixosModules.waybar = { config, pkgs, ... }: with config; {

    environment.systemPackages = with pkgs; [
      radeontop
      inputs.spotify-info.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    home-manager.users.aquanovae.programs.waybar.enable = true;
    home-manager.users.aquanovae.programs.waybar.settings.bar = {
      layer = "top";
      position = "top";
      margin = "3px 3px 0px";
      spacing = 7;
      reload_style_on_change = true;

      modules-left = [
        "custom/os-icon"
        "hyprland/workspaces"
      ];
    };

    # Modules
    home-manager.users.aquanovae.programs.waybar.settings.bar = {
      "custom/os-icon" = {
        format = "󱄅";
        tooltip = false;
      };

      "hyprland/workspaces" = {
        format = "{icon} {windows}";
        format-icons = {
          config = "󱇧";
          ranger = "󰝰";
        };
        all-outputs = true;
        show-special = true;
        special-visible-only = true;
        tooltip = false;
        window-rewrite-default = "󰘔";
        window-rewrite = {
          alacritty = "󰆍";
          coolercontrol = "󰔐";
          discord = "󰋎";
          firefox = "󰈹";
          gimp = "󱇣";
          inkscape = "󰕙";
          kicad = "󰭄";
          logisim-evolution = "󰣢";
          looking-glass-client = "󰖳";
          onlyoffice-desktopeditors = "󰈬";
          openrgb = "󰌬";
          pdfarranger = "󱔗";
          spotify = "󰓇";
          steam = "󰓓";
        };
      };

      "custom/spotify-info" = {
        format = "${mkSpan "󰓇" theme.green}  {}";
        tooltip = false;
        interval = 1;
        exec = pkgs.writeShellScript "spotify-info-module" ''
          spotify-info
        '';
      };

      "custom/shutdowntime" = {
        format = "{} 󱫌";
        tooltip = false;
        interval = 1;
        exec = pkgs.writeShellScript "shutdowntime" ''
          shutdown --show 2>&1 | \
            grep -Eo "[0-9]{2}:[0-9]{2}"
        '';
        on-click = pkgs.writeShellScript "shutdown-cancel" ''
          shutdown -c
        '';
      };

      wireplumber = {
        format = "{volume}% ${mkSpan "{icon}" theme.blue}";
        format-muted = "${mkSpan "󰝟" theme.blue}";
        format-icons = [ "󰕿" "󰖀" "󰕾" ];
        tooltip = false;
      };

      disk = {
      format = "{percentage_used}% ${mkSpan "󰋊" theme.blue}";
      path = "/";
        interval = 1;
        tooltip = false;
      };

      memory = {
        format = "{used}GB ${mkSpan "󰘚" theme.blue}";
        interval = 1;
        tooltip = false;
        };

      cpu = {
        format = "{usage}% ${mkSpan "󰍛" theme.blue}";
        interval = 1;
        tooltip = false;
      };

      "custom/gpu-info" = {
        format = "{} ${mkSpan "󰾲" theme.blue}";
        tooltip = false;
        interval = 1;
        exec = pkgs.writeShellScript "gpu-info" ''
          radeontop -b 3 -d - -l 1 | \
            grep -Eo "gpu [0-9]+\." | \
            sed -e "s/gpu //" -e "s/\./%/"
        '';
      };

      battery = {
        states = { low = 20; };
        format = "{capacity}% ${mkSpan "{icon}" theme.blue}";
        format-low = "{capacity}% ${mkSpan "󰂃" theme.bg0}";
        format-charging = "{capacity}% ${mkSpan "󰂄" theme.green}";
        format-icons = [ "󰁼" "󰁾" "󰂀" "󰂂" ];
        interval = 1;
        tooltip = false;
      };

      clock = {
        format = "{:%d/%m %H:%M}";
        interval = 1;
      };
    };

    # Style
    home-manager.users.aquanovae.programs.waybar.style = /*css*/ ''

      * {
        border-radius: 7px;
      }

      window#waybar {
        font-family: JetBrainsMono Nerd Font;
        font-size: 13px;
        background-color: rgba(0, 0, 0, 0);
        color: #${theme.fg};
      }

      .modules-left {
        border: 1px solid #${theme.bg3};
        background-color: #${theme.bg1};
      }

      .modules-right {
        border: 1px solid #${theme.bg3};
        background-color: #${theme.bg1};
      }

      #custom-os-icon {
        font-size: 23px;
        padding: 0px 13px 0px 7px;
        border-radius: 5px;
        color: #${theme.bg0};
        background-color: #${theme.blue};
      }

      #workspaces {
        border-radius: 5px;
        background-color: #${theme.bg0};
      }

      #workspaces button {
        margin: 0px;
        padding: 0px 12px 0px 8px;
      }

      #workspaces button label {
        font-size: 19px;
        color: #${theme.fg};
      }

      #workspaces button.active label {
        color: #${theme.blue};
      }

      #workspaces button.special label {
        color: #${theme.yellow};
      }

      #workspaces button:hover {
        background-color: #${theme.blue};
      }

      #workspaces button:hover label {
        color: #${theme.bg0};
      }

      #custom-spotify-info {
        padding: 0px 11px;
        color: #${theme.fg};
        background-color: alpha(#${theme.bg0}, 0.67);
      }

      #custom-shutdowntime {
        color: #${theme.bg0};
        background-color: #${theme.red};
        min-width: 80px;
      }

      #battery.low {
        color: #${theme.bg0};
        background-color: #${theme.red};
      }

      #battery.charging {
        color: #${theme.fg};
        background-color: #${theme.bg0};
      }

      #wireplumber,
      #disk,
      #memory,
      #cpu,
      #custom-gpu-info,
      #battery,
      #clock {
        color: #${theme.fg};
        background-color: #${theme.bg0};
      }

      /* width = (str_length + 1) * 10 */

      #wireplumber,
      #disk,
      #cpu,
      #battery,
      #custom-gpu-info,
      #clock {
        min-width: 70px;
      }

      #memory,
      #clock {
        min-width: 100px;
      }
    '';
  };

  flake.nixosModules.waybarSilverlight = { ... }: {

    imports = [ self.nixosModules.waybar ];

    home-manager.users.aquanovae.programs.waybar.settings.bar = {
      modules-center = [
        "custom/spotify-info"
      ];
      modules-right = [
        "custom/shutdowntime"
        "disk"
        "memory"
        "cpu"
        "custom/gpu-info"
        "clock"
      ];
    };
  };

  flake.nixosModules.waybarZenblade = { ... }: {

    imports = [ self.nixosModules.waybar ];

    home-manager.users.aquanovae.programs.waybar.settings.bar = {
      modules-center = [
        "custom/spotify-info"
      ];
      modules-right = [
        "custom/shutdowntime"
        "wireplumber"
        "disk"
        "memory"
        "cpu"
        "battery"
        "clock"
      ];
    };
  };

  flake.nixosModules.waybarLiveImage = { ... }: {

    imports = [ self.nixosModules.waybar ];

    home-manager.users.aquanovae.programs.waybar.settings.bar = {
      modules-right = [
        "memory"
        "cpu"
        "clock"
      ];
    };
  };
}
