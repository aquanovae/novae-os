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
        default = "saved";
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

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.pulseaudio = {
    enable = false;
    support32Bit = true;
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "fr_CH";
  time = {
    timeZone = "Europe/Zurich";
    hardwareClockInLocalTime = true;
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" ];
    })
  ];
}
