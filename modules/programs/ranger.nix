{ pkgs, username, ... }: {
  
  home-manager.users.${username}.programs.ranger = {
    enable = true;

    rifle = [{
      condition = "ext x?pdf?";
      command = "${pkgs.firefox}/bin/firefox \"$@\" &";
    }];
  };
}
