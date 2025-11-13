{ lib, ... }: {
  
  options.novaeos.theme = with lib; {

    bg0 = mkOption {
      type = types.str;
      default = "080808";
    };

    bg1 = mkOption {
      type = types.str;
      default = "181818";
    };

    bg2 = mkOption {
      type = types.str;
      default = "282828";
    };

    bg3 = mkOption {
      type = types.str;
      default = "383838";
    };

    fg = mkOption {
      type = types.str;
      default = "c6c6c6";
    };

    black = mkOption {
      type = types.str;
      default = "080808";
    };

    red = mkOption {
      type = types.str;
      default = "ff5d5d";
    };

    green = mkOption {
      type = types.str;
      default = "8cc85f";
    };

    yellow = mkOption {
      type = types.str;
      default = "e3c78a";
    };

    blue = mkOption {
      type = types.str;
      default = "80a0ff";
    };

    magenta = mkOption {
      type = types.str;
      default = "ae81ff";
    };

    cyan = mkOption {
      type = types.str;
      default = "79dac8";
    };

    white = mkOption {
      type = types.str;
      default = "c6c6c6";
    };
  };
}
