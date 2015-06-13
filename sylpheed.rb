class Sylpheed < Formula
  desc "A simple, lightweight email-client"
  homepage "http://sylpheed.sraoss.jp/en/"
  url "http://sylpheed.sraoss.jp/sylpheed/v3.4/sylpheed-3.4.2.tar.gz"
  sha256 "a4c47b570a5b565d14ff9933cf2e03fcb895034c1f072f9cd2c4a9867a2f2263"
  revision 1

  bottle do
    sha1 "768d366c0eb0b8de1ad50ce405b05c20c5a6b2dc" => :yosemite
    sha1 "e105665502bd22ec0d66b63d65213dd282a20b7f" => :mavericks
    sha1 "fc773eb0a83d176922ff88daa58856c60420ea3a" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "gpgme"
  depends_on "gtk+"
  depends_on "openssl"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-updatecheck"
    system "make", "install"
  end

  test do
    system "#{bin}/sylpheed", "--version"
  end
end
