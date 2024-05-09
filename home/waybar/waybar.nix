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

        "custom/os-icon" = {
          format = "󱄅";
        };

        reload_style_on_change = true;
      };
    };

    style = with config.colors; ''
      @define-color bg #${bg0};
      @define-color bg-alt #${bg1};
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
