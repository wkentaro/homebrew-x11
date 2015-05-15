class Gnumeric < Formula
  homepage "https://projects.gnome.org/gnumeric/"
  url "http://ftp.gnome.org/pub/GNOME/sources/gnumeric/1.12/gnumeric-1.12.22.tar.xz"
  sha256 "3908cfd6520b599eefefe222aadeaa5126394b54d9a9a7f5e0f938eb674dcf47"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    sha256 "29f856544019bc46cbea64a12a94787c664ad5edae716d6ce5914258c2ef2eab" => :yosemite
    sha256 "d27645b4aaf3066bb593b31aaf00468adaff35244e8fbee1050671b41756e14b" => :mavericks
    sha256 "d4e2a984bc16c17e6d41bcb1992d16c9fb097bcac40b5ed3a053cf4b7eb4d334" => :mountain_lion
  end

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
