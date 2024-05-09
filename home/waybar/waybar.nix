{ config, pkgs, ... }: {

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      bar = {
        layer = "top";
        position = "bottom";
        height = 34;

        modules-left = [ "hyprland/workspaces" ];
      };
    };

    style = with config.colors; ''
      :root {
        --bg0: #${bg0};
        --bg1: #${bg1};
        --fg: #${fg};

        --black: #${black};
        --gray: #${gray};
        --red: #${red};
        --yellow: #${yellow};
        --green: #${green};
        --cyan: #${cyan};
        --blue: #${blue};
        --magenta: #${magenta};
      }

      ${builtins.readFile ./waybar.css}
    '';
  };
}
