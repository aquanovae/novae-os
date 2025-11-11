{ username, ... }: {

  imports = [
    ./update-script.nix
  ];

  home-manager.users.${username}.home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "fr_CH";

  time.timeZone = "Europe/Zurich";
}
