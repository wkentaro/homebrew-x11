class Cardpeek < Formula
  homepage "http://pannetrat.com/Cardpeek/"
  url "http://downloads.pannetrat.com/install/cardpeek-0.8.4.tar.gz"
  mirror "https://github.com/DomT4/LibreMirror/raw/d1dff2e5714953308864a606618a85cbde2375a2/Cardpeek/cardpeek-0.8.4.tar.gz"
  sha256 "9c78dfdf84493c551b49447e4bb46c8d7b33f0785b93893222b70b6115013a85"

  bottle do
    cellar :any
    sha1 "71775a85560719e72a31284f1852b236daebab7c" => :mavericks
    sha1 "8801e8e235850927169195d1beac9a44566ba33c" => :mountain_lion
    sha1 "d6522d6a501745e2a3ef0744a06e78a6690f81be" => :lion
  end

  head "https://cardpeek.googlecode.com/svn/trunk/"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "lua"
  depends_on "openssl"
  depends_on :x11

  def install
    # always run autoreconf, needed to generate configure for --HEAD,
    # and otherwise needed to reflect changes to configure.ac
    system "autoreconf", "-i"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"cardpeek", "-v"
  end
end
