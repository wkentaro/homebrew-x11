class Geeqie < Formula
  desc "A lightweight Gtk+ based image viewer"
  homepage "http://geeqie.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/geeqie/geeqie/geeqie-1.1/geeqie-1.1.tar.gz"
  sha256 "5544e81c29917a647f19bfe800d9f0dd1cd5b890329feebd9abd80927e1afecf"
  revision 1

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    sha256 "48841dc3b56b889b2f6fa27292f4a878c48914a0a3e08f28a3251435784e86b0" => :yosemite
    sha256 "3c6da4b9e728231f8af7839ac3c63792a2330fe08f5c38138c6d4d783d5813b0" => :mavericks
    sha256 "7144f1ecdb495ffd82d8130059b55d2a12a80cea1087a0b633f504ae755f8877" => :mountain_lion
  end

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
