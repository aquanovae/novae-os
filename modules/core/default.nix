{ pkgs, username, ... }: {

  imports = [
    ./silent-boot.nix
    ./theme.nix
    ./user.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 2;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        splashImage = ./grub-background.png;
      };
    };
  };

  home-manager.users.${username}.home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "fr_CH";

  time = {
    timeZone = "Europe/Zurich";
    hardwareClockInLocalTime = true;
  };
}
