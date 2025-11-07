{ inputs, ... }: {

  perSystem = { pkgs, ... }: let
    wrappers = inputs.wrappers;
    callWrapper = path: pkgs.callPackage path { inherit wrappers; };
  in {

    packages = {
    };
  };
}
