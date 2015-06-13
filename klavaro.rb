class Klavaro < Formula
  desc "A free touch typing tutor program"
  homepage "http://klavaro.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/klavaro/klavaro-3.01.tar.bz2"
  mirror "https://mirrors.kernel.org/debian/pool/main/k/klavaro/klavaro_3.01.orig.tar.bz2"
  sha256 "ed71d522c29113d5d6517a65cbf95dafbe85ca4bb978139b804b98f128015e85"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    sha256 "c11fbb31b9e834c23d7c52bad6f2ae43232d051d22d764ef8173dbd4afbbe393" => :yosemite
    sha256 "0dfad2be7d509eb7192388ab6cdbbc7860e54cfe4773659e759f89c9a122c38e" => :mavericks
    sha256 "844995785b01e89d88a673ff100d065b2cbc535e875b6e8d90ace84c52237dfb" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gtk+3"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"klavaro", "--help-gtk"
  end
end
