{ inputs, rustPlatforms }: let

  pname = "daily-playlist";
  version = "1.0";

in rustPlatforms.buildRustPackage {

  inherit pname version;

  src = inputs.daily-playlist;
}
