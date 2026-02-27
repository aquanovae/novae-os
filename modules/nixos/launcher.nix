{ self, inputs, ... }: {

  flake.nixosModules.launcher = { config, ... }: with config; {

    imports = with self.nixosModules; [
      powermenu

      inputs.otter-launcher.nixosModules.default
    ];

    programs.otter-launcher.enable = true;
    programs.otter-launcher.settingsExtra = /*toml*/ ''

      [general]
      exec_cmd = "zsh -c"
      vi_mode = true

      [interface]
      header = "\u001B[30;44m 󱓞 \u001B[34;40m > \u001B[0m"
      place_holder = ""
      suggestion_lines = 5
      list_prefix = "      "
      prefix_color = "\u001B[35m"
      prefix_padding = 3
      description_color = "\u001B[90m"
      indicator_with_arg_module = "$"
    '';

    home-manager.users.aquanovae.programs.fzf = {
      enable = true;
      enableZshIntegration = true;

      defaultOptions = [
        "--layout=reverse"
      ];

      colors = {
        fg = "#${theme.fg}";
        bg = "#${theme.bg0}";
        hl = "#ff0000";
        "fg+" = "#${theme.blue}";
        "bg+" = "#${theme.bg1}";
        "hl+" = "#${theme.magenta}";
        preview_fg = "#${theme.red}";
        preview_bg = "#${theme.red}";
        gutter = "#${theme.red}";
      };
    };
  };
}
