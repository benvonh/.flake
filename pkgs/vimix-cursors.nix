{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "vimix-cursors";
  version = "2020-02-09";

  src = fetchFromGitHub {
    repo = "Vimix-cursors";
    owner = "vinceliuice";
    rev = "9bc292f40904e0a33780eda5c5d92eb9a1154e9c";
    sha256 = "sha256-zW7nJjmB3e+tjEwgiCrdEe5yzJuGBNdefDdyWvgYIUU=";
  };

  dontPatchELF = true;
  dontRewriteSymlinks = true;
  dontDropIconThemeCache = true;

  installPhase = ''
    mkdir -p $out/share/icons
    mv dist-white $out/share/icons/
  '';

  meta = with lib; {
    description = "Vimix-cursors for linux desktop";
    homepage = src.meta.homepage;
    license = licenses.gpl3Only;
    platforms = platforms.all;
  };
}
