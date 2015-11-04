class Gle < Formula
  homepage "http://glx.sourceforge.net/"
  url "https://downloads.sourceforge.net/glx/gle-graphics-4.2.4cf-src.tar.gz"
  version "4.2.4c"
  sha256 "21715f2943ca528ec94a8e129175693afc3b59bb03f92540a2150ffe72ab47ef"

  depends_on "pkg-config" => :build
  depends_on :x11
  depends_on "jpeg" => :optional
  depends_on "libtiff" => :optional
  depends_on "cairo"

  # fix namespace issues causing compilation errors
  # https://trac.macports.org/ticket/41760
  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/patches/985ba4f/gle/patch-hash-map.diff"
    sha256 "59769465080c539573313411c301314b18aa407e61858ce3b42d9f3b0660b1e4"
  end

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--with-arch=#{MacOS.preferred_arch}",
                          "--without-qt"

    inreplace "Makefile", "MKDIR_P", "mkdir -p"

    system "make"
    ENV.deparallelize
    system "make", "install"
  end
end
