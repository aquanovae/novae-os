{ inputs, self, ... }: {

  flake.nixosModules.core = { config, pkgs, ... }: with config; {

    imports = with self.nixosModules; [
      boot
      neovim
      starship
      theme
      zsh

      inputs.home-manager.nixosModules.default
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    users.users.aquanovae = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
    };

    home-manager.users.aquanovae.home = {
      username = "aquanovae";
      homeDirectory = "/home/aquanovae";
      stateVersion = "24.05";
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

    console.keyMap = "fr_CH";
    console.colors = [
      theme.black
      theme.red
      theme.green
      theme.yellow
      theme.blue
      theme.magenta
      theme.cyan
      theme.white
      theme.black
      theme.red
      theme.green
      theme.yellow
      theme.blue
      theme.magenta
      theme.cyan
      theme.white
    ];

    time.timeZone = "Europe/Zurich";
    i18n.defaultLocale = "en_GB.UTF-8";
  };
}
