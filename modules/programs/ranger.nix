{ extraPkgs, username, ... }: {
  
  home-manager.users.${username}.programs.ranger = {
    enable = true;

    rifle = [
      { condition = "ext x?pdf?";
        command = "${extraPkgs.zen-browser}/bin/zen-browser \"$@\" &";
      }
    ];
  };
}
