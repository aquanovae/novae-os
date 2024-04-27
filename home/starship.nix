{ config, pkgs, ... }: {

  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = lib.concatStrings [
        "[┌<$git_branch$git_status$rust >](bold dimmed cyan)"
        "[│](dimmed cyan)[\[$username@$hostname:$directory\]](bold cyan)"
        "[└$character](bold dimmed cyan)"
      ];

      username = {
        format = "[$user]($style)";
        style_user = "bold blue";
        style_root = "bold blue";
        show_always = true;
      };

      hostname = {
        format = "[$hostname]($style)";
        style = "bold purple";
        ssh_only = false;
      };

      directory = {
        format = "[$path]($style)";
        style = "white";
      };

      git_branch = {
        format = "[ $symbol$branch:⌈]($style)";
        style = "bold green";
      };

      git_status = {
        format = "[$ahead_behind$all_status]($style)[⌋](bold green)";
        style = "bold red";
        ahead = "🠕";
        behind = "🠗";
        diverged = "⥮";
        deleted = "𐄂";
      };

      rust = {
        format = "[ $symbol $numver]($style)";
        symbol = "rust";
        style = "yellow";
      };

      character = {
        format = "$symbol";
        success_symbol = "[>>>](bold green)";
        error_symbol = "[>>>](bold red)";
        vicmd_symbol = "[<<<](bold purple)";
      };
    };
  };
}
