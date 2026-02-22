{ ... }: {

  flake.nixosModules.lockscreenBattery = { config, ... }: with config.novaeos; {

    home-manager.users.${username}.programs.hyprlock.settings = {
      label = [{
        monitor = "";
        position = "200, 77";
        halign = "left";
        valign = "center";
        font_family = "JetBrainsMono Nerd Font";
        font_size = "11";
        text = ''
          cmd[update:60000] echo "$(cat /sys/class/power_supply/BAT0/capacity)% 󰁹"
        '';
      }];
    };
  };
}
