class Meld < Formula
  desc "A visual diff tool for developers"
  homepage "http://meldmerge.org"
  url "https://download.gnome.org/sources/meld/3.12/meld-3.12.3.tar.xz"
  sha256 "db3572c5c6905b09f4fc28415a7f6f223014391492dd2165ed1bc8512ac4e6fd"
  revision 1

  bottle do
    sha256 "be8062951844b1d73a550b886e7fc09318f4b7bc4024c259241753aa1cf0c04a" => :yosemite
    sha256 "0a92751895c5bcb9dc577bf5bbacbf4ae413b6c0feaef1921bc7b75922e90436" => :mavericks
    sha256 "c51f9a6f5f1e75ea4fb48676bc9e449dbdb53db41a43dc6a28d03f874ee27388" => :mountain_lion
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
