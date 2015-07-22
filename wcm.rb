class Wcm < Formula
  desc "Multi-platform open source orthodox file manager"
  homepage "http://wcm.linderdaum.com"
  url "https://github.com/corporateshark/WCMCommander/archive/release-0.20.0.tar.gz"
  sha256 "f166cfd0ff8511642402892cb8eee3b20c845f82c04ca4ca940996e611aa5aba"

  bottle do
    revision 1
    sha256 "7a856cd42b0264ecba4b8ff9681e007772d9fd7285ac676de5b16e72d6cf1767" => :yosemite
    sha256 "2bd7a1f210599a68e55563c2ff4fcc64e942878b8695a5cfe957b8958680effc" => :mavericks
    sha256 "e13f821249adb87673c14295b3e740eb08c6a893aceed75aca15250537fb7737" => :mountain_lion
  end

  depends_on "cmake" => :build
  depends_on "freetype"
  depends_on "libssh2"
  depends_on :x11

  needs :cxx11

  def install
    ENV.cxx11

    system "cmake", ".", "-DWITH_SMBCLIENT=OFF", *std_cmake_args
    system "make", "all"
    system "make", "install"
  end

  test do
    system "#{bin}/wcm", "--help"
  end
end
