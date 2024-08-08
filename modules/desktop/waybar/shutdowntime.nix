{ pkgs, ... }:

let
  shutdowntime = pkgs.writeShellScriptBin "shutdowntime" ''
    shutdown --show 2>&1 | \
      grep -Eo "[0-9]{2}:[0-9]{2}"
  '';
in {

  environment.systemPackages = [ shutdowntime ];
}
