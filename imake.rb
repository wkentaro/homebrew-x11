class Imake < Formula
  homepage "http://xorg.freedesktop.org"
  url "http://xorg.freedesktop.org/releases/individual/util/imake-1.0.7.tar.bz2"
  sha1 "52e236776133f217d438622034b8603d201a6ec5"

  depends_on "pkg-config" => :build
  depends_on "gcc"
  depends_on :x11

  patch :p0 do
    url "https://trac.macports.org/browser/trunk/dports/x11/imake/files/patch-imakemdep.h.diff?rev=127961&format=txt"
    sha1 "88a78651635d41072febe735dc76e75d44cf0957"
  end

  resource "xorg-cf-files" do
    url "http://xorg.freedesktop.org/releases/individual/util/xorg-cf-files-1.0.5.tar.bz2"
    sha1 "ae22eb81d56d018f0b3b149f70965ebfef2385fd"
  end

  def install
    ENV.deparallelize

    # imake runtime is broken when used with clang's cpp
    cpp_program = Formula["gcc"].prefix/"bin/cpp-#{Formula["gcc"].version_suffix}"
    inreplace "imakemdep.h", /::CPPCMD::/, cpp_program
    inreplace "imake.man", /__cpp__/, cpp_program

    # also use gcc's cpp during buildtime to pass ./configure checks
    ENV["RAWCPP"] = cpp_program

    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"

    resource("xorg-cf-files").stage do
      # Fix for different X11 locations.
      inreplace "X11.rules", "define TopXInclude	/**/",
                "define TopXInclude	-I#{MacOS::X11.include}"
      system "./configure", "--with-config-dir=#{lib}/X11/config",
                            "--prefix=#{HOMEBREW_PREFIX}"
      system "make", "install"
    end
  end
end
