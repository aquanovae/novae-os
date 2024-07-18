{ pkgs, ... }: {

  nix.settings.experimental-features = [ "nix-command" "flake" ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 2;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOsProber = true;
      };
    };
  };

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "fr_CH";

  users.users.rico = {
    isNormalUser = true;
    extraGroup = [ "wheel" ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  environement.systemPackages = with pkgs; [
    gh
    git
    neovim
    tree
  ];
  programs = {
    htop.enable = true;
    zsh.enable = true;
  };
}
