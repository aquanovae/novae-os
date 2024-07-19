{ config, lib, pkgs, ... }: 

let
  cfg = config.ricos.core;
in {

  options.ricos.core = {
    enable = lib.mkEnableOption "enable core";
  };

  config = lib.mkIf cfg.enable {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
      shell = pkgs.zsh;
    };

    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      gh
      git
      neovim
      tree
    ];

    programs = {
      htop.enable = true;
      zsh.enable = true;
    };
  };
}
