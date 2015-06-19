class Wcm < Formula
  desc "Multi-platform open source orthodox file manager"
  homepage "http://wcm.linderdaum.com"
  url "https://github.com/corporateshark/WCMCommander/archive/release-0.20.0.tar.gz"
  sha256 "f166cfd0ff8511642402892cb8eee3b20c845f82c04ca4ca940996e611aa5aba"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    sha256 "87e8b250aa565580146119e98575ac76dcb3707ba682c60149b9b4a41c7faec4" => :yosemite
    sha256 "fb4825624b5960fb881d147b370aec988f371c57ee21bc9f3ec61164b3948461" => :mavericks
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
