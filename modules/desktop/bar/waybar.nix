{ config, lib, ... }:

let
  cfg = config.ricos.desktop.bar;

  theme = config.ricos.theme;
  toSpan = icon: color: "<span color='#${color}' size='11pt'>${icon}</span>";
in {

  options.ricos.desktop.bar = {
    volume.enable = lib.mkEnableOption "enable volume";
    battery.enable = lib.mkEnableOption "enable battery";
  };

  config = {
    programs.waybar.enable = true;

    home-manager.users.rico.programs.waybar = {
      enable = true;
      systemd.enable = true;

      settings.bar = {
        layer = "top";
        position = "bottom";
        margin = "0px 6px 6px";
        spacing = 7;

        modules-left = [
          "custom/os-icon"
          "hyprland/workspaces"
        ];

        modules-right =
          (if cfg.volume.enable then [ "pulseaudio" ] else []) ++ [
          "disk"
          "memory"
          "cpu" ] ++
          (if cfg.battery.enable then [ "battery" ] else []) ++ [
          "clock"
        ];

        "custom/os-icon" = {
          format = "󱄅";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            terminal = "󰆍";
            browser = "󰈹";
          };
        };

        pulseaudio = {
          format = "{volume}% ${toSpan "{icon}" theme.blue}";
          format-muted = "${toSpan "󰝟" theme.blue}";
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
        };

        disk = {
          format = "{percentage_used}% ${toSpan "󰋊" theme.blue}";
          path = "/";
        };

        memory = {
          format = "{used}GB ${toSpan "󰘚" theme.blue}";
          interval = 1;
        };

        cpu = {
          format = "{usage}% ${toSpan "󰍛" theme.blue}";
          interval = 1;
        };

        battery = {
          states = {
            low = 20;
          };
          format = "{capacity}% ${toSpan "{icon}" theme.blue}";
          format-low = "{capacity}% ${toSpan "󰂃" theme.red}";
          format-charging = "{capacity}% ${toSpan "󰂄" theme.green}";
          format-icons = [
            "󰁼"
            "󰁾"
            "󰂀"
            "󰂂"
          ];
          interval = 3;
        };

        clock = {
          format = " {:%T\n%d/%m/%Y}";
          interval = 1;
        };

        reload_style_on_change = true;
      };

      style = ''
        @define-color bg #${theme.bg0};
        @define-color bg-alt #${theme.bg3};
        @define-color fg #${theme.fg};

        @define-color black #${theme.black};
        @define-color gray #${theme.gray};
        @define-color red #${theme.red};
        @define-color yellow #${theme.yellow};
        @define-color green #${theme.green};
        @define-color cyan #${theme.cyan};
        @define-color blue #${theme.blue};
        @define-color magenta #${theme.magenta};

        ${builtins.readFile ./waybar.css}
      '';
    };
  };
}
