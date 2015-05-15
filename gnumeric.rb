class Gnumeric < Formula
  homepage "https://projects.gnome.org/gnumeric/"
  url "http://ftp.gnome.org/pub/GNOME/sources/gnumeric/1.12/gnumeric-1.12.22.tar.xz"
  sha256 "3908cfd6520b599eefefe222aadeaa5126394b54d9a9a7f5e0f938eb674dcf47"

  option "python-scripting", "Enable Python scripting."

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gettext"
  depends_on "goffice"
  depends_on "pygobject" if build.include? "python-scripting"
  depends_on "rarian"
  depends_on :x11

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"

    # gnumeric installs this file that conflicts with other GTK packages
    (share/"glib-2.0/schemas/gschemas.compiled").unlink
  end
end
