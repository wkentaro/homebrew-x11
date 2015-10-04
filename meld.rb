class Meld < Formula
  desc "A visual diff tool for developers"
  homepage "http://meldmerge.org"
  url "https://download.gnome.org/sources/meld/3.14/meld-3.14.1.tar.xz"
  sha256 "f43f750ed00da7925ecc70d6c5fc398c46ccf5af2f9e14b42c9a8afc7fbc06a3"

  bottle do
    cellar :any_skip_relocation
    sha256 "1c993e96624036b7885b0ad0416aac54d176555daf45c7387039eb58db5ca8b7" => :el_capitan
    sha256 "33f8b3e4486e41871e901002091297b83e8a737137f70f13b7bcd7cc51d22229" => :yosemite
    sha256 "5c23c6f246e3c33431e6ebf45c2d13d69e275b63a5740faa1519bb038e3b45d0" => :mavericks
  end

  depends_on "intltool" => :build
  depends_on "itstool" => :build
  depends_on "libxml2" => [:build, "with-python"]
  depends_on :python
  depends_on "gtksourceview3"
  depends_on "pygobject3"
  depends_on "gobject-introspection"
  depends_on "hicolor-icon-theme"
  depends_on "gnome-icon-theme"

  def install
    ENV.append_path "PYTHONPATH", "#{Formula["libxml2"].opt_lib}/python2.7/site-packages"
    system "python", "setup.py", "--no-update-icon-cache",
           "--no-compile-schemas", "install", "--prefix=#{prefix}"
  end

  def post_install
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
    system "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache", "-f", "-t", "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end

  test do
    system "#{bin}/meld", "--version"
  end
end
