class Xplot < Formula
  homepage "http://www.xplot.org"
  url "http://www.xplot.org/xplot/xplot-0.90.7.1.tar.gz"
  sha256 "01ceac45540f2d01e6ffe368cc0e950f4bb7fe1d235efde5349a09199e662240"

  depends_on :x11

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    inreplace "Makefile", "man/man1", "share/man/man1"
    system "make", "install"
  end
end
