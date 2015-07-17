require "formula"

class Geomview < Formula
  homepage "http://www.geomview.org"
  # Restore the SF URL to the default when SF is back again
  url "http://http.debian.net/debian/pool/main/g/geomview/geomview_1.9.5.orig.tar.gz"
  mirror "https://downloads.sourceforge.net/project/geomview/geomview/1.9.5/geomview-1.9.5.tar.gz"
  sha1 "26186046dc18ab3872e7104745ae474908ee54d1"
  revision 1

  depends_on :x11
  depends_on "openmotif"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
