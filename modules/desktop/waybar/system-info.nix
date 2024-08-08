{ config, ... }:

let
  theme = config.ricos.theme;
  toSpan = icon: color: "<span color='#${color}' size='11pt'>${icon}</span>";
in {

  home-manager.users.rico.programs.waybar = {
    settings.bar = {
      pulseaudio = {
        format = "{volume}% ${toSpan "{icon}" theme.blue}";
        format-muted = "${toSpan "󰝟" theme.blue}";
        format-icons = [ "󰕿" "󰖀" "󰕾" ];
        tooltip = false;
      };

      disk = {
        format = "{percentage_used}% ${toSpan "󰋊" theme.blue}";
        path = "/";
        interval = 1;
        tooltip = false;
      };

      memory = {
        format = "{used}GB ${toSpan "󰘚" theme.blue}";
        interval = 1;
        tooltip = false;
      };

      cpu = {
        format = "{usage}% ${toSpan "󰍛" theme.blue}";
        interval = 1;
        tooltip = false;
      };

      battery = {
        states = { low = 20; };
        format = "{capacity}% ${toSpan "{icon}" theme.blue}";
        format-low = "{capacity}% ${toSpan "󰂃" theme.red}";
        format-charging = "{capacity}% ${toSpan "󰂄" theme.green}";
        format-icons = [ "󰁼" "󰁾" "󰂀" "󰂂" ];
        interval = 1;
        tooltip = false;
      };

      clock = {
        format = "{:%H:%M}";
        tooltip-format = "{:%d/%m/%Y}";
        interval = 1;
      };
    };

    style = /*css*/ ''
      #pulseaudio, #disk, #memory, #cpu, #battery, #clock {
        background-color: #${theme.bg0};
      }

      #pulseaudio, #disk, #cpu, #battery, #clock {
        min-width: 65px;
      }

      #memory {
        min-width: 95px;
      }
    '';
  };
}
