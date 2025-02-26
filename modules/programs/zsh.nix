# ------------------------------------------------------------------------------
# Shell configuration
# ------------------------------------------------------------------------------
{ username, ... }: let

  novae-os = "/home/${username}/novae-os/";

in {

  programs.zsh.enable = true;

  home-manager.users.${username}.programs.zsh = {
    enable = true;

    enableCompletion = true;

    shellAliases = {
      # Aliases for cargo
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
      nb      = "nix build";
      nbi     = "sudo nix build --impure ${novae-os}/#nixosConfigurations.live-image.config.system.build.isoImage";
      ncg     = "sudo nix-collect-garbage --delete-older-than 3d";
      nd      = "nix develop -c zsh";
      nfu     = "nix flake update --flake ${novae-os}";
      nr      = "nix run";
      nrs     = "sudo nixos-rebuild switch --impure --flake ${novae-os}";
      nrsm    = "NIX_SSHOPTS='-i ~/.ssh/minix -p 777' nixos-rebuild switch --flake ~/novae-os/#minix-server --target-host aquanovae@aquanovae.space --use-remote-sudo";
      ns      = "nix-shell --run zsh";
      nsg     = "l /nix/store | grep -i";
      nsp     = "nix-shell --run zsh -p";

      # Other aliases
      ".."    = "cd ..";
      tree    = "tree --dirsfirst";
    };
  };
}
