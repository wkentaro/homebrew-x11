require "formula"

class Geomview < Formula
  homepage "http://www.geomview.org"

  # Restore the SF URL to the default when SF is back again
  url "http://http.debian.net/debian/pool/main/g/geomview/geomview_1.9.5.orig.tar.gz"
  mirror "https://downloads.sourceforge.net/project/geomview/geomview/1.9.5/geomview-1.9.5.tar.gz"
  sha1 "26186046dc18ab3872e7104745ae474908ee54d1"
  revision 1

  bottle do
    sha256 "a1ced45e9de6821f5916ce8e08352ee018b746ae0d11f383b8a25c1d9a6155c1" => :yosemite
    sha256 "21353d2c13993a3dcd4454545df80bc4e1efaf5f7f266892e3db04495170344f" => :mavericks
    sha256 "fd04d0dbb5f380bddf07b0fab5be53c04cd15278bca90ecedbd2b9576e317f23" => :mountain_lion
  end

  depends_on :x11
  depends_on "openmotif"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
