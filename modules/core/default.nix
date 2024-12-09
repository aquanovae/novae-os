# ------------------------------------------------------------------------------
# Core configuration shared for all hosts
# ------------------------------------------------------------------------------
{ pkgs, username, ... }: {

  imports = [
    ./silent-boot.nix
    ./theme.nix
    ./user.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot = {
    # Use zen kernel
    kernelPackages = pkgs.linuxPackages_zen;

    # Grub config
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

  # Base home manager config
  home-manager.users.${username}.home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    stateVersion = "24.05";
  };

  # Audio setup
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  # Language and time config
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "fr_CH";
  time = {
    timeZone = "Europe/Zurich";
    hardwareClockInLocalTime = true;
  };

  # Add jetbrains font
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
