{ config, pkgs, ... }: {

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      bar = with config.colors; let 
        toSpan = icon: color: "<span color='#${color}' size='11pt'>${icon}</span>";
      in {
        layer = "top";
        position = "bottom";
        margin = "0px 6px 6px";
        spacing = 7;

        modules-left = [
          "custom/os-icon"
          "hyprland/workspaces"
        ];

        modules-right = [
          "pulseaudio"
          "disk"
          "memory"
          "cpu"
          "battery"
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
          format = "{volume}% ${toSpan "{icon}" blue}";
          format-muted = "${toSpan "󰝟" blue}";
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
        };

        disk = {
          format = "{percentage_used}% ${toSpan "󰋊" blue}";
          path = "/";
        };

        memory = {
          format = "{used}GB ${toSpan "󰘚" blue}";
          interval = 1;
        };

        cpu = {
          format = "{usage}% ${toSpan "󰍛" blue}";
          interval = 1;
        };

        battery = {
          states = {
            low = 20;
          };
          format = "{capacity}% ${toSpan "{icon}" blue}";
          format-low = "{capacity}% ${toSpan "󰂃" red}";
          format-charging = "{capacity}% ${toSpan "󰂄" green}";
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
    };

    style = with config.colors; ''
      @define-color bg #${bg0};
      @define-color bg-alt #${bg3};
      @define-color fg #${fg};

      @define-color black #${black};
      @define-color gray #${gray};
      @define-color red #${red};
      @define-color yellow #${yellow};
      @define-color green #${green};
      @define-color cyan #${cyan};
      @define-color blue #${blue};
      @define-color magenta #${magenta};

      ${builtins.readFile ./waybar.css}
    '';
  };
}
