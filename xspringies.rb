class Xspringies < Formula
  homepage "http://www.cs.rutgers.edu/~decarlo/software.html"
  url "http://www.cs.rutgers.edu/~decarlo/software/xspringies-1.12.tar.Z"
  sha256 "08a3e9f60d1f1e15d38d62dd62baab18f6ad57ee139b0ef41452be66e4ad6a28"

  bottle do
    sha1 "42c98753f4430639d961128d450c9d1ba01124a0" => :yosemite
    sha1 "7a791f236b5738a666523d091686a015152677fb" => :mavericks
    sha1 "23817a7161135c3a368d91e027133911802424a8" => :mountain_lion
  end

  depends_on :x11

  def install
    inreplace "Makefile.std" do |s|
      s.change_make_var! "LIBS", "-L#{MacOS::X11.lib} -lm -lX11"
      s.gsub! "mkdirhier", "mkdir -p"
    end
    system "make", "-f", "Makefile.std", "DDIR=#{prefix}/", "MANDIR=#{man1}", "install"
    mv "#{man1}/xspringies.man", "#{man1}/xspringies.1"
  end
end
