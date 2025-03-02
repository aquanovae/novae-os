{ config, lib, pkgs, username, ... }: let 

  launch-ranger = pkgs.writeShellScriptBin "launch-ranger" ''
    function condition() {
      hyprctl -j clients | \
        jq ".[].title" | \
        grep "ranger"
    }

    function launch() {
      alacritty -T ranger -e ranger &
    }

    condition || launch
  '';

  launch-config = pkgs.writeShellScriptBin "launch-config" ''
    function condition() {
      hyprctl -j clients | \
        jq ".[].title" | \
        grep "config"
    }

    function launch() {
      alacritty -T config --working-directory /home/${username}/novae-os &
      sleep 0.03
      alacritty -T config --working-directory /home/${username}/novae-os -e vim &
    }

    condition || launch
  '';

in {

  config = lib.mkIf config.novaeOs.desktopEnvironment.enable {
    environment.systemPackages = [
      launch-ranger
      launch-config
    ];
  };
}
