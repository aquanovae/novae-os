{ username, ... }: {

  home-manager.users.${username}.programs.waybar.settings.bar = {
    modules-left = [
      "custom/os-icon"
      "hyprland/workspaces"
      "hyprland/submap"
    ];

    modules-right = [
      "clock"
    ];
  };
}
