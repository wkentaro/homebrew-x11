class Xastir < Formula
  desc "X amateur station tracking and information reporting"
  homepage "http://www.xastir.org/"
  url "https://downloads.sourceforge.net/xastir/xastir-2.0.6.tar.gz"
  sha256 "e46debd3f67ea5c08e2f85f03e26653871a9cdd6d692c8eeee436c3bc8a8dd43"
  revision 2

  bottle do
    sha256 "8102eea7c0c8e3ff42d75dd93977ad5fb13f1da42811dddf412c626a3a311949" => :yosemite
    sha256 "f2c446dcb0d5601c9b4a3f5a8589118a4eaa45ee835314fec013f997af7be1b2" => :mavericks
    sha256 "1eb333db4d86934f8bfb0844f2872831e106fe2d49d91f243c40d01f72ea6a6b" => :mountain_lion
  end

  depends_on "proj"
  depends_on "pcre"
  depends_on "berkeley-db"
  depends_on "gdal"
  depends_on "libgeotiff"
  depends_on "openmotif"
  depends_on "jasper"
  depends_on "graphicsmagick"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
