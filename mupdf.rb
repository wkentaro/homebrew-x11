class Mupdf < Formula
  homepage "http://mupdf.com"
  url "http://mupdf.com/downloads/mupdf-1.7a-source.tar.gz"
  sha256 "8c035ffa011fc44f8a488f70da3e6e51889508bbf66fe6b90a63e0cfa6c17d1c"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    cellar :any
    sha256 "a6afbf12678464fcfe083bf8d4e63f30ae25cf0e6ffbe302f6f55ba416a237ce" => :yosemite
    sha256 "3880793f6a4855135640e57f7328770344c47c3ea5d582f6075034a4063598bf" => :mavericks
    sha256 "f1217ab12adf316067f7e85b5a82dc1790ca0fdaab7dc0be9073412da6059ace" => :mountain_lion
  end

  depends_on :macos => :snow_leopard
  depends_on :x11
  depends_on "openssl"

  conflicts_with "mupdf-tools",
    :because => "mupdf and mupdf-tools install the same binaries."

  def install
    system "make", "install",
           "build=release",
           "verbose=yes",
           "CC=#{ENV.cc}",
           "prefix=#{prefix}"
  end

  test do
    pdf = test_fixtures("test.pdf")
    assert_match /Homebrew test/, shell_output("#{bin}/mudraw -F txt #{pdf}")
  end
end
