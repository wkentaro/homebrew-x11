class Imake < Formula
  homepage "http://xorg.freedesktop.org"
  url "http://xorg.freedesktop.org/releases/individual/util/imake-1.0.7.tar.bz2"
  sha256 "690c2c4ac1fad2470a5ea73156cf930b8040dc821a0da4e322014a42c045f37e"
  revision 1

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    sha256 "c87f83a1a19a9b75ad66550b728b6d079ee40c422af1fb1c63814d574c35379a" => :yosemite
    sha256 "e623f7ff86eb5a0d1231b7cfde05739ae049ea3e0faf84741bb4f003a2bc028a" => :mavericks
    sha256 "e52e0277c21eb66f1bb70f65a4c30e2f4a8b85567d14dd75e549c9c6af8b7472" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "gcc"
  depends_on :x11

  patch :p0 do
    url "https://trac.macports.org/browser/trunk/dports/x11/imake/files/patch-imakemdep.h.diff?rev=127961&format=txt"
    sha256 "1f7a24f625d2611c31540d4304a45f228767becafa37af01e1695d74e612459e"
  end

  resource "xorg-cf-files" do
    url "http://xorg.freedesktop.org/releases/individual/util/xorg-cf-files-1.0.5.tar.bz2"
    sha256 "ed23b85043edecc38fad4229e0ebdb7ff80b570e746bc03a7c8678d601be7ed4"
  end

  def install
    ENV.deparallelize

    # imake runtime is broken when used with clang's cpp
    cpp_program = Formula["gcc"].opt_bin/"cpp-#{Formula["gcc"].version_suffix}"
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
