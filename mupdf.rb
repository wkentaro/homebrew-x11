class Mupdf < Formula
  homepage "http://mupdf.com"
  url "http://mupdf.com/downloads/mupdf-1.7a-source.tar.gz"
  sha256 "8c035ffa011fc44f8a488f70da3e6e51889508bbf66fe6b90a63e0cfa6c17d1c"

  bottle do
    cellar :any
    sha256 "cd08e744981da8217edff2417534197b6fc1123057044672af4ad45454c18995" => :yosemite
    sha256 "8d4a45552059a14df044e32152d8907d3b0e95f0445a9d10bfe0d876e4d00ca4" => :mavericks
    sha256 "4692fc5f8ba4a47b7d9efee0b2e1251b0a3538eb0dcebbf5e2e0392a8da28a94" => :mountain_lion
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
