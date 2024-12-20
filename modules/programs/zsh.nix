# ------------------------------------------------------------------------------
# Shell configuration
# ------------------------------------------------------------------------------
{ config, username, ... }: let

  novae-os = "/home/${username}/novae-os/";

in {

  programs.zsh.enable = true;

  home-manager.users.${username}.programs.zsh = {
    enable = true;

    enableCompletion = true;

    shellAliases = {
      # Aliases for cargo
      cb = "cargo build";
      cr = "cargo run";

      # Aliases for git
      ga = "git add";
      gb = "git branch";
      gcm = "git commit -m";
      gd = "git diff";
      gf = "git fetch";
      gl = "git log --oneline --graph --all -20";
      gll = "git log --oneline --graph --all";
      gm = "git merge";
      gmv = "git mv";
      gp = "git push";
      gpl = "git pull";
      gr = "git rebase";
      grm = "git rm";
      grstr = "git restore";
      gs = "git status";
      gst = "git stash";
      gstl = "git stash list";
      gstp = "git stash pop";
      gsw = "git switch";

      # Aliases for ls
      l = "ls -l --color=auto";
      ll = "ls -la --color=auto";

      # Alias to run nix-shell with zsh
      ns = "nix-shell --run zsh";
      nsp = "nix-shell --run -p";

      # Aliases for system management
      nbi = "sudo nix build ${novae-os}/#nixosConfigurations.live-image.config.system.build.isoImage";
      ncg = "sudo nix-collect-garbage --delete-older-than 3d";
      nfu = "nix flake update --flake ${novae-os}";
      nrs = "sudo nixos-rebuild switch --impure --flake ${novae-os}";

      # Other aliases
      ".." = "cd ..";
      nsg = "l /nix/store | grep -i";
      tree = "tree --dirsfirst";

    };
  };
}
