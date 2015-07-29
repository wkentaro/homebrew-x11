class Gnumeric < Formula
  desc "GNOME Spreadsheet Application"
  homepage "https://projects.gnome.org/gnumeric/"
  url "https://download.gnome.org/sources/gnumeric/1.12/gnumeric-1.12.23.tar.xz"
  sha256 "00474cbf1e70f62062974d0beb5f65ebc45d1047bc8fd0a1133e3d9725e19551"

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
