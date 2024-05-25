with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "rust";
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ 
    alsa-lib
    cargo
    libGL
    libxkbcommon
    rustc
    udev
    wayland
  ];
  LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${lib.makeLibraryPath [
    libGL
    libxkbcommon
    wayland
  ]}";
}
