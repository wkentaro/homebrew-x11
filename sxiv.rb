class Sxiv < Formula
  homepage "https://github.com/muennich/sxiv"
  url "https://github.com/muennich/sxiv/archive/v1.3.1.tar.gz"
  mirror "https://mirrors.kernel.org/debian/pool/main/s/sxiv/sxiv_1.3.1.orig.tar.gz"
  sha256 "9a30a1b036e1c17212128554709da3f2d65d3beaef2e0a73097af5e35cf11d0e"

  head "https://github.com/muennich/sxiv.git"

  depends_on :x11
  depends_on "imlib2"
  depends_on "giflib"
  depends_on "libexif"

  def install
    system "make", "config.h"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system "#{bin}/sxiv", "-v"
  end
end
