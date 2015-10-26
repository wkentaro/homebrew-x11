class Gnumeric < Formula
  desc "GNOME Spreadsheet Application"
  homepage "https://projects.gnome.org/gnumeric/"
  url "https://download.gnome.org/sources/gnumeric/1.12/gnumeric-1.12.24.tar.xz"
  sha256 "c59d5271b27366008bccb4d53ad8333da36d837003a018892f2da325c1449551"

  bottle do
    sha256 "113d9cb86597b49ac68ee5701fff6b01abc33ebd794767863fb53d9693e29a84" => :yosemite
    sha256 "87cba0d9ce23e7d884992423349beafaa6b7419beb407cd35c27df0a3b735ea4" => :mavericks
    sha256 "ca98c7ec558aea34c0a5d618199ab0eb4e878b8c19c6516bc040e0e0c00c3399" => :mountain_lion
  end

  option "with-python-scripting", "Enable Python scripting."

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gettext"
  depends_on "goffice"
  depends_on "pygobject" if build.include? "python-scripting"
  depends_on "rarian"
  depends_on "gnome-icon-theme"

  deprecated_option "python-scripting" => "with-python-scripting"

  def install
    # ensures that the files remain within the keg
    inreplace "component/Makefile.in", "GOFFICE_PLUGINS_DIR = @GOFFICE_PLUGINS_DIR@", "GOFFICE_PLUGINS_DIR = @libdir@/goffice/@GOFFICE_API_VER@/plugins/gnumeric"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-schemas-compile"
    system "make", "install"
  end

  def post_install
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
  end

  test do
    system "#{bin}/gnumeric", "--version"
  end
end
