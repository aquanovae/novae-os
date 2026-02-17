{ config, pkgs, ... }: {
  
  home-manager.users.${config.novaeos.username}.programs.ranger = {
    enable = true;

    rifle = [{
      condition = "ext x?pdf?";
      command = "${pkgs.firefox}/bin/firefox \"$@\" &";
    }];
  };
}
