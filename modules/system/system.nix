{ pkgs, ... }: {

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

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
      };
    };
  };

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "fr_CH";

  users.users.rico = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
