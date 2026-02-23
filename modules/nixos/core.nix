{ inputs, self, ... }: {

  flake.nixosModules.core = { config, pkgs, ... }: with config.novaeos; {

    imports = with self.nixosModules; [
      neovim
      starship
      theme
      user
      zsh

      inputs.home-manager.nixosModules.default
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    boot = {
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelPackages = pkgs.linuxPackages_zen;
    };

    boot.kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
    ];

    boot.loader = {
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };

    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      splashImage = ../../assets/grub-background.png;
      useOSProber = true;
    };

    environment.systemPackages = with pkgs; [
      jq
      gh
      git
      nix-sweep
      tree
    ];

    programs = {
      ssh.startAgent = true;
      htop.enable = true;
    };

    home-manager.users.${username}.home = {
      username = "${username}";
      homeDirectory = "/home/${username}";
      stateVersion = "24.05";
    };

    time.timeZone = "Europe/Zurich";
    i18n.defaultLocale = "en_GB.UTF-8";
    console.keyMap = "fr_CH";
  };

  flake.nixosModules.user = { config, pkgs, lib, ... }: {

    options.novaeos = with lib; {
      username = mkOption { type = types.str; default = "aquanovae"; };
    };

    config.users.users.${config.novaeos.username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
    };
  };
}
