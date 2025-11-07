{ username, ... }: {

  imports = [
    ./theme.nix
    ./update-script.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  home-manager.users.${username}.home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "fr_CH";

  time.timeZone = "Europe/Zurich";
}
