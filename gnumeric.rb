class Gnumeric < Formula
  desc "GNOME Spreadsheet Application"
  homepage "https://projects.gnome.org/gnumeric/"
  url "https://download.gnome.org/sources/gnumeric/1.12/gnumeric-1.12.23.tar.xz"
  sha256 "00474cbf1e70f62062974d0beb5f65ebc45d1047bc8fd0a1133e3d9725e19551"

  bottle do
    sha256 "29f856544019bc46cbea64a12a94787c664ad5edae716d6ce5914258c2ef2eab" => :yosemite
    sha256 "d27645b4aaf3066bb593b31aaf00468adaff35244e8fbee1050671b41756e14b" => :mavericks
    sha256 "d4e2a984bc16c17e6d41bcb1992d16c9fb097bcac40b5ed3a053cf4b7eb4d334" => :mountain_lion
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
