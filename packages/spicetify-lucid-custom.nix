{ inputs, stdenv }: let

  pname = "spicetify-lucid-custom";
  version = "latest";

in stdenv.mkDerivation {

  inherit pname version;

  src = inputs.spicetify-lucid;
}
