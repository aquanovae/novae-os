{ config, lib, pkgs, ... }:

let
  cfg = config.ricos.programs.zsh;
  home = config.home-manager.users.rico.home;
in {

  options.ricos.programs.zsh = {
    enable = lib.mkEnableOption "enable zsh";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh.enable = true;

    home.programs.zsh = {
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

        rcg = "sudo nix-collect-garbage --delete-older-than 7d";
        rrs = "sudo nixos-rebuild switch --flake ~/ricos/#silverlight";
        rfu = "sudo nix flake update /home/rico/ricos && rrs";
      };
    };
  };
}
