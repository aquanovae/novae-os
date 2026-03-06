{ ... }: {

  flake.nixosModules.zsh = { pkgs, ... }: {

    home-manager.users.aquanovae.programs.zsh.enable = true;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      syntaxHighlighting.enable = true;
    };

    programs.zsh.promptInit = /*bash*/ ''
      eval "$(${pkgs.starship}/bin/starship init zsh)"
    '';

    programs.zsh.interactiveShellInit = /*bash*/ ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      export ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
    '';

    programs.zsh.shellAliases = {

      # Aliases for cargo
      ca      = "cargo add";
      cb      = "cargo build";
      cr      = "cargo run";

      # Aliases for git
      ga      = "git add";
      gb      = "git branch";
      gcm     = "git commit -m";
      gd      = "git diff";
      gf      = "git fetch";
      gl      = "git log --oneline --graph --all -20";
      gll     = "git log --oneline --graph --all";
      gm      = "git merge";
      gmv     = "git mv";
      gp      = "git push";
      gpl     = "git pull";
      gplr    = "git pull --rebase=true";
      gr      = "git rebase";
      grm     = "git rm";
      grst    = "git reset";
      grstr   = "git restore";
      grstrs  = "git restore --staged";
      gs      = "git status";
      gst     = "git stash";
      gstl    = "git stash list";
      gstm    = "git stash -m";
      gstp    = "git stash pop";
      gsw     = "git switch";

      # Aliases for ls
      l       = "ls -l --color=auto";
      ll      = "ls -la --color=auto";

      # Nix aliases
      nb      = "nix build -vL";
      nbi     = "sudo nix build --impure .#nixosConfigurations.live-image.config.system.build.isoImage";
      ncg     = "nix-collect-garbage --delete-older-than 3d";
      ncgs    = "sudo nix-collect-garbage --delete-older-than 3d";
      nd      = "nix develop -c zsh";
      nfu     = "nix flake update --flake .";
      nr      = "nix run -vL --option substitute false";
      nra     = "nix run -vL --option substitute false . --";
      nrs     = "sudo nixos-rebuild switch --impure --flake .#";
      nrsv    = "sudo nixos-rebuild switch --impure --flake .# --verbose --print-build-logs";
      ns      = "nix-shell --run zsh";
      nsa     = "nix-sweep analyze";
      nscs    = "sudo nix-sweep cleanout --keep-max=3 --gc system";
      nscu    = "nix-sweep cleanout --keep-max=3 --gc user";
      nsg     = "l /nix/store | grep -i";
      nsp     = "nix-shell --run zsh -p";

      # Ssh aliases
      scpn    = "scp /home/aquanovae/novae-os/ aquanovae@aquanovae.space:";
      ssham   = "ssh-add ~/.ssh/minix";
      sshm    = "ssh aquanovae@aquanovae.space";

      # Other aliases
      ".."    = "cd ..";
      tree    = "tree --dirsfirst";
    };
  };
}
