{ pkgs, ... }: let 

  rconfig = pkgs.writeShellScriptBin "launch-rconfig" ''

    condition() {
      hyprctl -j clients | \
        jq ".[].title" | \
        grep "rconfig"
    }

    launch() {
      alacritty -T rconfig --working-directory /home/rico/ricos &
      sleep 0.01
      alacritty -T rconfig --working-directory /home/rico/ricos -e vim &
    }

    condition || launch
  '';
in {

  environment.systemPackages = [
    rconfig
  ];
}
