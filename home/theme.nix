{ config, lib, ... }: with lib; {
  
  options.config.colors = {
    bg = mkOption {
      type = types.str;
      default = "#1d1f21";
    };
  };
}
