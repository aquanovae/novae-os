{ inputs, rustPlatform }: let

  pname = "daily-playlist";
  version = "1.0";

in rustPlatform.buildRustPackage {

  inherit pname version;

  src = inputs.daily-playlist;

  useFetchCargoVendor = true;
  cargoHash = "sha256-3eGj2YedGeYFdN7X6RoSrQj0oh7siFTc6+w7fzENVyM=";
}
