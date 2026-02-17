{ ... }: {

  flake.nixosModules.theme = { lib, ... }: let 

    mkColor = color: lib.mkOption { type = lib.types.str; default = "${color}"; };

  in {
    options.novaeos.theme = {
      bg0     = mkColor "080808";
      bg1     = mkColor "181818";
      bg2     = mkColor "282828";
      bg3     = mkColor "383838";
      fg      = mkColor "c6c6c6";
      black   = mkColor "080808";
      red     = mkColor "ff5d5d";
      green   = mkColor "8cc85f";
      yellow  = mkColor "e3c78a";
      blue    = mkColor "80a0ff";
      magenta = mkColor "ae81ff";
      cyan    = mkColor "79dac8";
      white   = mkColor "c6c6c6";
    };
  };
}
