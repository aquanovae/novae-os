{ username, ... }:

let
  ricosPath = "/home/rico/ricos";
in {

  programs.zsh.enable = true;

  home-manager.users.${username}.programs.zsh = {
    enable = true;

    enableCompletion = true;

    shellAliases = {
      ".." = "cd ..";

      cb = "cargo build";
      cr = "cargo run";

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

      l = "ls -l --color=auto";
      ll = "ls -la --color=auto";

      rcg = "sudo nix-collect-garbage --delete-older-than +7";
      rrs = "sudo nixos-rebuild switch --flake ${ricosPath}";
      rfu = "sudo nix flake update ${ricosPath} && rrs && rcg";
      rbi = "sudo nix build ${ricosPath}/#nixosConfigurations.live-image.config.system.build.isoImage";

      tree = "tree --dirsfirst";
    };
  };
}
