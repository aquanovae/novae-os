{ ... }: let

  toSpan = icon: color: "<span color='#${color}' size='11pt'>${icon}</span>";

in {

  flake.nixosModules.waybarModules = { config, pkgs, ... }: with config.novaeos; {

    home-manager.users.${username}.programs.waybar.settings.bar = {

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
          looking-glass-client = "󰖳";
          openrgb = "󰌬";
          pwvucontrol = "󰙪";
          spotify = "󰓇";
          steam = "󰓓";
        };
      };


      "custom/spotify-info" = {
        format = "${toSpan "󰓇" theme.green}  {}";
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


      "custom/gpu-info" = {
        format = "{} ${toSpan "󰾲" theme.blue}";
        tooltip = false;
        interval = 1;
        exec = pkgs.writeShellScript "gpu-info" ''
          radeontop -b 3 -d - -l 1 | \
            grep -Eo "gpu [0-9]+\." | \
            sed -e "s/gpu //" -e "s/\./%/"
        '';
      };


      battery = {
        states = {
          low = 20;
        };
        format = "{capacity}% ${toSpan "{icon}" theme.blue}";
        format-low = "{capacity}% ${toSpan "󰂃" theme.bg0}";
        format-charging = "{capacity}% ${toSpan "󰂄" theme.green}";
        format-icons = [ "󰁼" "󰁾" "󰂀" "󰂂" ];
        interval = 1;
        tooltip = false;
      };


      clock = {
        format = "{:%d/%m %H:%M}";
        interval = 1;
      };
    };
  };
}
