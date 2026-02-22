{ inputs, self, ... }: {

  flake.nixosModules.core = { config, pkgs, ... }: {

    imports = with self.nixosModules; [
      boot
      neovim
      starship
      theme
      user
      zsh

      inputs.home-manager.nixosModules.default
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

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

    home-manager.users.${config.novaeos.username}.home = {
      username = "${config.novaeos.username}";
      homeDirectory = "/home/${config.novaeos.username}";
      stateVersion = "24.05";
    };

    time.timeZone = "Europe/Zurich";
    i18n.defaultLocale = "en_GB.UTF-8";
    console.keyMap = "fr_CH";
  };
}
