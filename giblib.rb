class Giblib < Formula
  homepage "http://freshmeat.net/projects/giblib"
  url "http://linuxbrit.co.uk/downloads/giblib-1.2.4.tar.gz"
  mirror "http://www.mirrorservice.org/sites/distfiles.macports.org/giblib/giblib-1.2.4.tar.gz"
  sha256 "176611c4d88d742ea4013991ad54c2f9d2feefbc97a28434c0f48922ebaa8bac"

  bottle do
    cellar :any
    revision 1
    sha1 "af84435cd0dd636b90b420c590cf7e1f57dee612" => :yosemite
    sha1 "a58b8b515fc558f42b8b8ea6e427fb0af42355fe" => :mavericks
    sha1 "4f3acb6bade2b18edddd1e3b9100a4a15368d6e2" => :mountain_lion
  end

  depends_on :x11
  depends_on "imlib2" => :build

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/giblib-config", "--version"
  end
end
