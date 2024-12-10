{ inputs, rustPlatform }: let

  pname = "daily-playlist";
  version = "1.0";

in rustPlatform.buildRustPackage {

  inherit pname version;

  src = inputs.daily-playlist;

  cargoHash = "sha256-B75tW2YEIsHhTKLEN7aPC+TbSSTuVLj0dFgHJufNV/4=";
}
