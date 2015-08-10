class Geoclue < Formula
  homepage "http://www.freedesktop.org/wiki/Software/GeoClue"
  url "https://launchpad.net/geoclue/trunk/0.12/+download/geoclue-0.12.0.tar.gz"
  sha256 "0f533f177ae9aa35e807a01c754840f66df9579f5524552f14f2b5ba670a4696"

  depends_on :x11
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "dbus-glib"
  depends_on "gconf"
  depends_on "libxslt"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end

