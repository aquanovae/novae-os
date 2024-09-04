{ de-setup, username, ... }: {

  imports = [
    ./${de-setup}.nix
    ./modules.nix
    ./style.nix
  ];

  home-manager.users.${username}.programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.bar = {
      layer = "top";
      position = "bottom";
      margin = "0px 6px 6px";
      spacing = 7;
      reload_style_on_change = true;
    };
  };
}
