{ config, lib, pkgs, username, ... }: let

  theme = config.novaeOs.theme;
  toSpan = icon: color: "<span color='#${color}' size='11pt'>${icon}</span>";

in {

  config = lib.mkIf config.novaeOs.desktopEnvironment.enable {
    home-manager.users.${username}.programs.waybar.settings.bar = {

      # Decorative module displaying distro logo
      "custom/os-icon" = {
        format = "󱄅";
        tooltip = false;
      };


      # Display window manager active workspaces
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

        # Assign logo to programs
        window-rewrite-default = "󰘔";
        window-rewrite = {
          alacritty = "󰆍";
          coolercontrol = "󰔐";
          discord = "󰋎";
          gimp = "󱇣";
          inkscape = "󰕙";
          openrgb = "󰌬";
          pavucontrol = "󰙪";
          spotify = "󰓇";
          steam = "󰓓";
          zen = "󰖟";
        };
      };


      # Display currently playing track info
      "custom/spotify-info" = {
        format = "${toSpan "󰓇" theme.green}  {}";
        tooltip = false;
        restart-interval = 1;

        exec = pkgs.writeShellScript "spotify-info" ''
          spotify-manager track-info
        '';
      };


      # Display shutdown time if shutdown timer is active
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


      # Display volume info
      wireplumber = {
        format = "{volume}% ${toSpan "{icon}" theme.blue}";
        format-muted = "${toSpan "󰝟" theme.blue}";
        format-icons = [ "󰕿" "󰖀" "󰕾" ];
        tooltip = false;
      };


      # Display disk usage
      disk = {
      format = "{percentage_used}% ${toSpan "󰋊" theme.blue}";
      path = "/";
        interval = 1;
        tooltip = false;
      };


      # Display memory usage
      memory = {
        format = "{used}GB ${toSpan "󰘚" theme.blue}";
        interval = 1;
        tooltip = false;
        };


      # Display CPU usage
      cpu = {
        format = "{usage}% ${toSpan "󰍛" theme.blue}";
        interval = 1;
        tooltip = false;
      };


      # Display GPU usage
      "custom/gpu-info" = {
        format = "{} ${toSpan "󰾲" theme.blue}";
        tooltip = false;
        interval = 1;

        # radeontop is rather slow
        # Probably can find lighter program
        exec = pkgs.writeShellScript "gpu-info" ''
          radeontop -b 3 -d - -l 1 | \
            grep -Eo "gpu [0-9]+\." | \
            sed -e "s/gpu //" -e "s/\./%/"
        '';
      };


      # Display battery status
      battery = {
        states = { low = 20; };
        format = "{capacity}% ${toSpan "{icon}" theme.blue}";
        format-low = "{capacity}% ${toSpan "󰂃" theme.red}";
        format-charging = "{capacity}% ${toSpan "󰂄" theme.green}";
        format-icons = [ "󰁼" "󰁾" "󰂀" "󰂂" ];
        interval = 1;
        tooltip = false;
      };


      # Display time and date on hover
      clock = {
        format = "{:%H:%M %d/%m}";
        tooltip-format = "{:%d/%m/%Y}";
        interval = 1;
      };
    };
  };
}
