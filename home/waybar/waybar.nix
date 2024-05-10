{ config, pkgs, ... }: {

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      bar = {
        layer = "top";
        position = "bottom";
        margin = "0px 6px 6px";

        modules-left = [
          "custom/os-icon"
          "hyprland/workspaces"
        ];

        modules-right = [
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
