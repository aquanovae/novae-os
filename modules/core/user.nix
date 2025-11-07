{ config, lib, pkgs, ... }: {

  options.novaeos = with lib; {
    username = mkOption {
      type = types.str;
      default = "aquanovae";
    };
  };

  config = {
    users.users.${config.novaeos.username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
    };
  };
}
