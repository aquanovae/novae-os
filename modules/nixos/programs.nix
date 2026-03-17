{ inputs, self, ... }: {

  flake.nixosModules.programsMinimal = { pkgs, ... }: {

    imports = with self.nixosModules; [
      alacritty
      launcher
    ];

    environment.systemPackages = [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs.otter-launcher.settingsExtra = /*toml*/ ''

      [[modules]]
      description = "zen browser"
      prefix = "ze"
      cmd = "zen"
      unbind_proc = true
    '';
  };

  flake.nixosModules.programsFull = { pkgs, ... }: {

    imports = with self.nixosModules; [
      programsMinimal
      ranger
      spotify
    ];

    environment.systemPackages = with pkgs; [
      discord
      gimp
      inkscape
      kicad
      logisim-evolution
      onlyoffice-desktopeditors
      pdfarranger
    ];

    programs.steam.enable = true;

    programs.otter-launcher.settingsExtra = /*toml*/ ''

      [[modules]]
      description = "discord"
      prefix = "di"
      cmd = "discord"
      unbind_proc = true

      [[modules]]
      description = "gimp"
      prefix = "gi"
      cmd = "gimp"
      unbind_proc = true

      [[modules]]
      description = "inkscape"
      prefix = "is"
      cmd = "inkscape"
      unbind_proc = true

      [[modules]]
      description = "kicad"
      prefix = "kc"
      cmd = "kicad"
      unbind_proc = true

      [[modules]]
      description = "logisim"
      prefix = "ls"
      cmd = "logisim-evolution"
      unbind_proc = true

      [[modules]]
      description = "onlyoffice"
      prefix = "oo"
      cmd = "onlyoffice-desktopeditors"
      unbind_proc = true

      [[modules]]
      description = "pdfarranger"
      prefix = "pa"
      cmd = "pdfarranger"
      unbind_proc = true

      [[modules]]
      description = "spotify"
      prefix = "sp"
      cmd = "spotify"
      unbind_proc = true

      [[modules]]
      description = "steam"
      prefix = "st"
      cmd = "steam"
      unbind_proc = true
    '';
  };

  flake.nixosModules.programsSilverlight = { ... }: {

    imports = with self.nixosModules; [
      openrgb
      programsFull
    ];

    programs.coolercontrol.enable = true;

    programs.otter-launcher.settingsExtra = /*toml*/ ''

      [[modules]]
      description = "coolercontrol"
      prefix = "cc"
      cmd = "coolercontrol"
      unbind_proc = true

      [[modules]]
      description = "openrgb"
      prefix = "or"
      cmd = "openrgb"
      unbind_proc = true
    '';
  };
}
