{ lib, ... }: with lib; {
  
  options.novaeOs.theme = {
    bg0     = mkOption { type = types.str; };
    bg1     = mkOption { type = types.str; };
    bg2     = mkOption { type = types.str; };
    bg3     = mkOption { type = types.str; };
    fg      = mkOption { type = types.str; };

    black   = mkOption { type = types.str; };
    gray    = mkOption { type = types.str; };
    red     = mkOption { type = types.str; };
    yellow  = mkOption { type = types.str; };
    green   = mkOption { type = types.str; };
    cyan    = mkOption { type = types.str; };
    blue    = mkOption { type = types.str; };
    magenta = mkOption { type = types.str; };
  };

  config.novaeOs.theme = {
    bg0     = "202020";
    bg1     = "303030";
    bg2     = "404040";
    bg3     = "505050";
    fg      = "bdbdbd";

    black   = "323437";
    gray    = "949494";
    red     = "ff5d5d";
    yellow  = "e3c78a";
    green   = "8cc85f";
    cyan    = "79dac8";
    blue    = "80a0ff";
    magenta = "ae81ff";
  };
}
