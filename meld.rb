class Meld < Formula
  desc "A visual diff tool for developers"
  homepage "http://meldmerge.org"
  url "https://download.gnome.org/sources/meld/3.12/meld-3.12.3.tar.xz"
  sha256 "db3572c5c6905b09f4fc28415a7f6f223014391492dd2165ed1bc8512ac4e6fd"
  revision 1

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    sha256 "f89bb13a8259ebb369b4d4c0d4544d0463e24b915fccfc2251bccd935b61dcfb" => :yosemite
    sha256 "919f88e6f8589380b4badac2e3774c295fcec489916aa9deb1620a07573acaaf" => :mavericks
    sha256 "fcb05111aa42887745b558e3f612bc4566fc14dfead4b7261ed3292795d73e05" => :mountain_lion
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
