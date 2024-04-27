{ config, lib, ... }: with lib; {
  
  options.colors = {
    bg0 = mkOption { type = types.str; };
    bg1 = mkOption { type = types.str; };
    bg2 = mkOption { type = types.str; };
    bg3 = mkOption { type = types.str; };
    bg4 = mkOption { type = types.str; };
    bg5 = mkOption { type = types.str; };
    bg6 = mkOption { type = types.str; };
    fg  = mkOption { type = types.str; };

    gray    = mkOption { type = types.str; };
    red     = mkOption { type = types.str; };
    green   = mkOption { type = types.str; };
    yellow  = mkOption { type = types.str; };
    blue    = mkOption { type = types.str; };
    magenta = mkOption { type = types.str; };
    cyan    = mkOption { type = types.str; };
    white   = mkOption { type = types.str; };
  };

  config.colors = {
    bg0 = "#1d1d1d";
    bg1 = "#323232";
    bg2 = "#484848";
    bg3 = "#5f5f5f";
    bg4 = "#777777";
    bg5 = "#909090";
    bg6 = "#aaaaaa";
    fg  = "#c5c5c5";

    gray    = "#373737";
    red     = "#cc6666";
    green   = "#b5bd68";
    yellow  = "#f0c674";
    blue    = "#81a2be";
    magenta = "#b294bb";
    cyan    = "#8abeb7";
    white   = "#f0f0f0";
  };
}
