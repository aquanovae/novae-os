{ appimageTools, inputs }: let

  pname = "zen-browser";
  version = "twilight";
  src = inputs.zen-browser;
  appimageContent = appimageTools.extractType1 { inherit pname version src; };
  desktopFilePath = "$out/share/applications/${pname}.desktop";

in appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -D ${appimageContent}/zen.desktop ${desktopFilePath}
    substituteInPlace ${desktopFilePath} \
      --replace-fail "Exec=zen %u" "Exec=$out/bin/${pname}"
  '';
}
