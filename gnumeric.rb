class Gnumeric < Formula
  desc "GNOME Spreadsheet Application"
  homepage "https://projects.gnome.org/gnumeric/"
  url "https://download.gnome.org/sources/gnumeric/1.12/gnumeric-1.12.24.tar.xz"
  sha256 "c59d5271b27366008bccb4d53ad8333da36d837003a018892f2da325c1449551"

  bottle do
    sha256 "2993a57c8bf837175b330e3f679aafc92472187bdab90afb5347b39ba3223746" => :el_capitan
    sha256 "9d3bd6a2196a3703a631791ac4c4700c3739dcb331f03ca34b383f929218f028" => :yosemite
    sha256 "454e04f7c2df9bfbe4a2e3df104800fedbba10d4fbdf694ef3fbea201cbe5eb3" => :mavericks
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
