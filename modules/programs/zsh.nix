# ------------------------------------------------------------------------------
# Shell configuration
# ------------------------------------------------------------------------------
{ username, ... }:

let
  ricosPath = "/home/${username}/ricos";
in {

  programs.zsh.enable = true;

  home-manager.users.${username}.programs.zsh = {
    enable = true;

    enableCompletion = true;

    shellAliases = {
      ".." = "cd ..";

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
      rbi = "sudo nix build ${ricosPath}/#nixosConfigurations.live-image.config.system.build.isoImage";
      rcg = "sudo nix-collect-garbage --delete-older-than 3d";
      rfu = "sudo nix flake update --commit-lock-file ${ricosPath} && rrs";
      rrs = "sudo nixos-rebuild switch --flake ${ricosPath} --impure";

      tree = "tree --dirsfirst";
    };
  };
}
