class Sptk < Formula
  homepage "http://sp-tk.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/sp-tk/SPTK/SPTK-3.8/SPTK-3.8.tar.gz"
  sha256 "028d6b3230bee73530f3d67d64eafa32cf23eaa987545975d260d0aaf6953f2b"

  bottle do
    sha256 "d3aec4b0144c9393718edb8e5aa8a112083ba61433a8b35ad8ea8357d9ea7bbf" => :yosemite
    sha256 "1d1dc69333fe242e558235822b33d4bebaea0296f7963a6ae2b5b400102d03cc" => :mavericks
    sha256 "accf671e09d35e65547ebc3e8e46f2b4c1221822ea972d2dee5e57a931ac99cc" => :mountain_lion
  end

  depends_on :x11

  option "with-examples", "Install example data and documentation"

  conflicts_with "libextractor", :because => "both install `extract`"
  conflicts_with "num-utils", :because => "both install `average`"
  conflicts_with "boost-bcp", :because => "both install `bcp`"
  conflicts_with "rcs", :because => "both install `merge`"

  fails_with :gcc do
    cause "Segmentation fault during linking."
  end

  fails_with :llvm do
    cause "Segmentation fault during linking."
  end

  resource "examples-data" do
    url "https://downloads.sourceforge.net/project/sp-tk/SPTK/SPTK-3.8/SPTKexamples-data-3.8.tar.gz"
    sha256 "3f37f279540e63ca55f0630d4aff8ba123203b0062b69fe379a8f1a951fddca9"
  end

  resource "examples-pdf" do
    url "https://downloads.sourceforge.net/project/sp-tk/SPTK/SPTK-3.8/SPTKexamples-3.8.pdf"
    sha256 "3bf21903a13b6b3d57b9684ad3800610c141e9333fcf9ee9df8543b234e567ce"
  end

  def install
    system "./configure", "CC=#{ENV.cc}", "--prefix=#{prefix}"
    system "make", "install"

    if build.with? "examples"
      (doc/"examples").install resource("examples-data"),
                               resource("examples-pdf")
    end
  end

  test do
    system "#{bin}/impulse", "-h"
    system "#{bin}/impulse -n 10 -l 100 | hexdump"
  end
end
