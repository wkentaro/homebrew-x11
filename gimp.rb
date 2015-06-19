class Gimp < Formula
  desc "GNU Image Manipulation Program"
  homepage "http://www.gimp.org"
  url "http://download.gimp.org/pub/gimp/v2.8/gimp-2.8.14.tar.bz2"
  sha256 "d82a958641c9c752d68e35f65840925c08e314cea90222ad845892a40e05b22d"
  head "https://github.com/GNOME/gimp.git", :branch => "gimp-2-8"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    sha256 "fd5b0d50ae84e060b3056fbd9a4062a65705bcd3682b89982dca7e9316e290be" => :yosemite
    sha256 "0fe19bce7983265a835dfa899325f0adaed4e966fc5a7a6c6af9c53bf4d2a62d" => :mavericks
    sha256 "46fe567462e8ff5f76bc143b3321384f5cf06f430d13b2aa4851db7541d41ae0" => :mountain_lion
  end

  depends_on :x11 => :recommended
  depends_on "pkg-config" => :build
  depends_on "gettext" => :build
  depends_on "intltool" => :build
  depends_on "gegl"
  depends_on "babl"
  depends_on "fontconfig"
  depends_on "pango"
  depends_on "gtk+"
  depends_on "gtk-mac-integration"
  depends_on "cairo"
  depends_on "pygtk"
  depends_on "glib"
  depends_on "gdk-pixbuf"
  depends_on "freetype"
  depends_on "xz" # For LZMA
  depends_on "d-bus"
  depends_on "aalib"
  depends_on "librsvg"
  depends_on "libpng" => :recommended
  depends_on "libwmf" => :recommended
  depends_on "libtiff" => :recommended
  depends_on "ghostscript" => :optional
  depends_on "poppler" => :optional
  depends_on "libexif" => :optional

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-silent-rules
      --disable-dependency-tracking
      --disable-glibtest
      --disable-gtktest
      --datarootdir=#{share}
      --sysconfdir=#{etc}
    ]

    args << "--without-x" if build.without? "x11"
    args << "--without-libtiff" if build.without? "libtiff"
    args << "--without-libpng" if build.without? "libpng"
    args << "--without-wmf" if build.without? "libwmf"
    args << "--without-poppler" if build.without? "poppler"
    args << "--without-libexif" if build.without? "libexif"

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/gimp", "--version"
  end
end
