{ config, pkgs, ... }: {

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      bar = with config.colors; let 
        toSpan = icon: color: size: "<span color='#${color}' size='${size}pt'>${icon}</span>";
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
          "wireplumber"
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

        wireplumber = {
          format = "${toSpan "{icon}" blue "13"} {volume}%";
          format-muted = "${toSpan "󰝟" blue "13"}";
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
        };

        disk = {
          format = "${toSpan "󰋊" blue "12"} {percentage_used}%";
          path = "/";
        };

        memory = {
          format = "${toSpan "󰘚" blue "12"} {used}GB";
          interval = 1;
        };

        cpu = {
          format = "${toSpan "󰍛" blue "13"} {usage}%";
          interval = 1;
        };

        battery = {
          states = {
            low = 20;
          };
          format = "${toSpan "{icon}" blue "12"} {capacity}%";
          format-low = "${toSpan "󰂃" red "12"} {capacity}%";
          format-charging = "${toSpan "󰂄" green "12"} {capacity}%";
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
