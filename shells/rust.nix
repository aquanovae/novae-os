with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "rust";
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ 
    alsa-lib
    cargo
    rustc
    udev
  ];
}
