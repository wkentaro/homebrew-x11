class Klavaro < Formula
  homepage "http://klavaro.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/klavaro/klavaro-3.01.tar.bz2"
  mirror "https://mirrors.kernel.org/debian/pool/main/k/klavaro/klavaro_3.01.orig.tar.bz2"
  sha256 "ed71d522c29113d5d6517a65cbf95dafbe85ca4bb978139b804b98f128015e85"

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gtk+3"
  depends_on "gtkdatabox"
  depends_on :x11

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"klavaro", "--help-gtk"
  end
end
