class Inkscape < Formula
  desc "A professional vector graphics editor"
  homepage "https://inkscape.org/"
  url "https://inkscape.org/en/gallery/item/3854/inkscape-0.91.tar.gz"
  mirror "https://mirrors.kernel.org/debian/pool/main/i/inkscape/inkscape_0.91.orig.tar.gz"
  sha256 "2ca3cfbc8db53e4a4f20650bf50c7ce692a88dcbf41ebc0c92cd24e46500db20"
  revision 3

  bottle do
    sha256 "b8178793aea18bcd80aa660949a8fd6e8e13f9668b93973f15a8ab3ffe9caea6" => :yosemite
    sha256 "10c3882dd6a99421e58c587f1f388a89d2b2a11d63c3bc6a8b72fb0336527e0b" => :mavericks
    sha256 "4362bbfcb8b44b4c53ea7f16f3c840bcea6a87e5145f0c1dc11623504352e6a9" => :mountain_lion
  end

  head do
    url "lp:inkscape", :using => :bzr
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "boost-build" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "poppler" => :optional
  depends_on "bdw-gc"
  depends_on "boost"
  depends_on "cairomm"
  depends_on "gettext"
  depends_on "glibmm"
  depends_on "gsl"
  depends_on "gtkmm"
  depends_on "hicolor-icon-theme"
  depends_on "little-cms"
  depends_on "pango"
  depends_on "popt"

  needs :cxx11

  if MacOS.version < :mavericks
    fails_with :clang do
      cause "inkscape's dependencies will be built with libstdc++ and fail to link."
    end
  end

  def install
    ENV.cxx11
    ENV.append "LDFLAGS", "-liconv"

    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-silent-rules
      --disable-strict-build
      --enable-lcms
      --without-gnome-vfs
    ]
    args << "--disable-poppler-cairo" if build.without? "poppler"

    system "./autogen.sh" if build.head?
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/inkscape", "-x"
  end
end
