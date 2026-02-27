{ ... }: {

  flake.nixosModules.alacritty = { config, ... }: with config; {
    
    home-manager.users.aquanovae.programs.alacritty.enable = true;
    home-manager.users.aquanovae.programs.alacritty.settings = {
      font.normal.family = "JetBrainsMono Nerd Font";
      font.size = 12;

      colors.primary = {
        background = "#${theme.bg0}";
        foreground = "#${theme.fg}";
      };

      colors.cursor = {
        cursor = "#${theme.fg}";
        text = "#${theme.bg0}";
      };

      colors.normal = {
        black = "#${theme.black}";
        red = "#${theme.red}";
        green = "#${theme.green}";
        yellow = "#${theme.yellow}";
        blue = "#${theme.blue}";
        magenta = "#${theme.magenta}";
        cyan = "#${theme.cyan}";
        white = "#${theme.white}";
      };

      keyboard.bindings = [{
        mods = "Control";
        key = "Enter";
        action = "SpawnNewInstance";
      }];
    };
  };
}
