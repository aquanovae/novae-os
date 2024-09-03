{ lib, ... }: with lib; {
  
  options.ricos.theme = {
    bg0 = mkOption { type = types.str; };
    bg1 = mkOption { type = types.str; };
    bg2 = mkOption { type = types.str; };
    bg3 = mkOption { type = types.str; };
    fg  = mkOption { type = types.str; };

    black   = mkOption { type = types.str; };
    gray    = mkOption { type = types.str; };
    red     = mkOption { type = types.str; };
    yellow  = mkOption { type = types.str; };
    green   = mkOption { type = types.str; };
    cyan    = mkOption { type = types.str; };
    blue    = mkOption { type = types.str; };
    magenta = mkOption { type = types.str; };
  };

  config.ricos.theme = {
    bg0 = "1f2329";
    bg1 = "282c34";
    bg2 = "30363f";
    bg3 = "323641";
    fg  = "a0a8b7";

    black   = "0e1013";
    gray    = "535965";
    red     = "e55561";
    yellow  = "e2b86b";
    green   = "8ebd6b";
    cyan    = "48b0bd";
    blue    = "4fa6ed";
    magenta = "bf68d9";
  };
}
