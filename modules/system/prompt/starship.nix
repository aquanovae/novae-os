{ ... }: {

  programs.starship.enable = true;

  home-manager.users.rico.programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = ''
        [┌<$git_branch$git_status$nix_shell >](bold cyan)
        [│](cyan)[\[$username@$hostname:$directory\]](bold cyan)
        [└$character](bold cyan)
      '';

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
        format = "[ $ahead_behind$all_status]($style)[⌋](bold green)";
        style = "bold red";
        conflicted = "󰩌 ";
        ahead = "󰩎 ";
        behind = "󰥦 ";
        diverged = "󱪖 ";
        up_to_date = "󰸩 ";
        untracked = "󱀶 ";
        stashed = "󱀳 ";
        modified = "󱇨 ";
        staged = "󰻭 ";
        renamed = "󱀹 ";
        deleted = "󱀷 ";
      };

      nix_shell = {
        format = "$symbol[ $name]($style)";
        style = "cyan";
        symbol = "[ nix-shell:](bold blue)";
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
