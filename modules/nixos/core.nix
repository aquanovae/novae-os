{ self, ... }: {

  flake.nixosModules.core = { config, pkgs, ... }: with config; {

    imports = with self.nixosModules; [
      boot
      neovim
      starship
      syncthing
      theme
      zsh
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    users.users.aquanovae = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
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
