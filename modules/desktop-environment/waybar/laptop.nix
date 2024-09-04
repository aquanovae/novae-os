{ username, ... }: {

  home-manager.users.${username}.programs.waybar.settings.bar = {
    modules-left = [
      "custom/os-icon"
      "hyprland/workspaces"
      "hyprland/submap"
    ];

    modules-center = [
      "custom/playerctl-info"
    ];

    modules-right = [
      "custom/shutdowntime"
      "pulseaudio"
      "disk"
      "memory"
      "cpu"
      "battery"
      "clock"
    ];
  };
}
