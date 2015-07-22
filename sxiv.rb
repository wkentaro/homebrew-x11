class Sxiv < Formula
  homepage "https://github.com/muennich/sxiv"
  url "https://github.com/muennich/sxiv/archive/v1.3.1.tar.gz"
  mirror "https://mirrors.kernel.org/debian/pool/main/s/sxiv/sxiv_1.3.1.orig.tar.gz"
  sha256 "9a30a1b036e1c17212128554709da3f2d65d3beaef2e0a73097af5e35cf11d0e"

  head "https://github.com/muennich/sxiv.git"

  bottle do
    sha256 "cd000f4147840935793888585f06b51e42a72e68e0fee6ecd1a9030440766a1c" => :yosemite
    sha256 "60cf275f71414ff48f5462e079c133fae94ba49762aa2f8428ac6a2305210059" => :mavericks
    sha256 "76b5d60ce52886ff4ce6e48cec2abb99b5d850fdab60d33c739a89fe7fdc1b13" => :mountain_lion
  end

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
