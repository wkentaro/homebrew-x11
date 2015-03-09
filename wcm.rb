class Wcm < Formula
  desc "Multi-platform open source orthodox file manager"
  homepage "http://wcm.linderdaum.com"
  url "https://github.com/corporateshark/WCMCommander/archive/release-0.20.0.tar.gz"
  sha256 "f166cfd0ff8511642402892cb8eee3b20c845f82c04ca4ca940996e611aa5aba"

  depends_on "cmake" => :build
  depends_on "freetype"
  depends_on "libssh2"
  depends_on :x11
  depends_on :macos => :mavericks

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
