class Geeqie < Formula
  desc "A lightweight Gtk+ based image viewer"
  homepage "http://geeqie.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/geeqie/geeqie/geeqie-1.1/geeqie-1.1.tar.gz"
  sha256 "5544e81c29917a647f19bfe800d9f0dd1cd5b890329feebd9abd80927e1afecf"
  revision 1

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gettext"
  depends_on "gtk+"
  depends_on "gnu-getopt"
  depends_on "imagemagick" => :recommended
  depends_on "exiv2" => :recommended
  depends_on "little-cms" => :recommended
  depends_on "fbida" => :recommended

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-glibtest",
                          "--disable-gtktest"
    system "make", "install"
  end

  test do
    system "#{bin}/geeqie", "--version"
  end
end
