{ config, ... }:

let
  theme = config.ricos.theme;
  toSpan = icon: color: "<span color='#${color}' size='11pt'>${icon}</span>";
in {

  home-manager.users.rico.programs.waybar.settings.bar = {
    "custom/os-icon" = {
      format = "󱄅";
      tooltip = false;
    };

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

    pulseaudio = {
      format = "{volume}% ${toSpan "{icon}" theme.blue}";
      format-muted = "${toSpan "󰝟" theme.blue}";
      format-icons = [
        "󰕿"
        "󰖀"
        "󰕾"
      ];
      tooltip = false;
    };

    disk = {
      format = "{percentage_used}% ${toSpan "󰋊" theme.blue}";
      path = "/";
      interval = 3;
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
      tooltip = false;
    };

    clock = {
      format = "{:%H:%M}";
      tooltip-format = "{:%d/%m/%Y}";
      interval = 1;
    };
  };
}
