{ pkgs, ... }: let 

  ranger = pkgs.writeShellScriptBin "launch-ranger" ''
    
    condition() {
      hyprctl -j clients | \
        jq ".[].title" | \
        grep "ranger"
    }

    launch() {
      alacritty -T ranger -e ranger &
    }

    condition || launch
  '';

  rconfig = pkgs.writeShellScriptBin "launch-rconfig" ''

    condition() {
      hyprctl -j clients | \
        jq ".[].title" | \
        grep "rconfig"
    }

    launch() {
      alacritty -T rconfig --working-directory /home/rico/ricos &
      sleep 0.03
      alacritty -T rconfig --working-directory /home/rico/ricos -e vim &
    }

    condition || launch
  '';
in {

  environment.systemPackages = [
    ranger
    rconfig
  ];
}
