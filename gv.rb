class Gv < Formula
  homepage "https://www.gnu.org/s/gv/"
  url "http://ftpmirror.gnu.org/gv/gv-3.7.4.tar.gz"
  mirror "https://ftp.gnu.org/gnu/gv/gv-3.7.4.tar.gz"
  sha256 "2162b3b3a95481d3855b3c4e28f974617eef67824523e56e20b56f12fe201a61"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    sha256 "e6e1fa970d2db69c4e7b42967e6e7243f1ce8636914e33dfa3442072aa4c85e2" => :yosemite
    sha256 "5dbf9c94b4d45542e9c1aff5a215f5e29bc00e77cb3ff4bd057cfe56f8bb4874" => :mavericks
    sha256 "8a22714fae1bb26c9f6ac7acc3f13b6ebcb601e4a935f752ff53117849907ece" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "ghostscript" => "with-x11"
  depends_on :x11 => "2.7.2"

  skip_clean "share/gv/safe-gs-workdir"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-SIGCHLD-fallback"
    system "make", "install"
  end
end
