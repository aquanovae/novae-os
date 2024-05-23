with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "rust";
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ 
    alsa-lib
    cargo
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    rustc
    udev
  ];
}
