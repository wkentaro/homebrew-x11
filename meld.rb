class Meld < Formula
  desc "A visual diff tool for developers"
  homepage "http://meldmerge.org"
  url "https://download.gnome.org/sources/meld/3.14/meld-3.14.1.tar.xz"
  sha256 "f43f750ed00da7925ecc70d6c5fc398c46ccf5af2f9e14b42c9a8afc7fbc06a3"

  bottle do
    cellar :any
    sha256 "c63bd4dad5ea7b550937c9a021f8a982ee9a3753148d068d9a047871cc370654" => :yosemite
    sha256 "b494dcc6052d1c57171c1aa42593b016be4eca58899992224efe23cb398333b0" => :mavericks
    sha256 "9be56dc3d6220c0af3cdcd70be3ca9cdb315ab45add50fc0dbc036c03f289f95" => :mountain_lion
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
