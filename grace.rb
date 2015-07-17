class Grace < Formula
  homepage "http://plasma-gate.weizmann.ac.il/Grace/"
  url "https://mirrors.kernel.org/debian/pool/main/g/grace/grace_5.1.25.orig.tar.gz"
  sha256 "751ab9917ed0f6232073c193aba74046037e185d73b77bab0f5af3e3ff1da2ac"
  revision 1

  bottle do
    sha256 "f19e0ebdfa9a35e179bf2df57be26e044e6bf05bf0a26c510413b625db7ef663" => :yosemite
    sha256 "13b146752da42b360dc7593b735c2f832ab21e19cc562af23fd6651325f528a7" => :mavericks
    sha256 "140d6cbe6068aa81ade6b46dfe0feca2221a69f8df35130517338b974f44c565" => :mountain_lion
  end

  depends_on :x11
  depends_on "pdflib-lite"
  depends_on "jpeg"
  depends_on "fftw"
  depends_on "openmotif"

  def install
    ENV.O1 # https://github.com/Homebrew/homebrew/issues/27840#issuecomment-38536704
    system "./configure", "--disable-debug",
                          "--prefix=#{prefix}",
                          "--enable-grace-home=#{prefix}"
    system "make", "install"
    share.install "fonts", "examples"
    man1.install Dir["doc/*.1"]
    doc.install Dir["doc/*"]
  end

  test do
    system bin/"gracebat", share/"examples/test.dat"
    assert_equal "12/31/1999 23:59:59.999",
                 shell_output("#{bin}/convcal -i iso -o us 1999-12-31T23:59:59.999").chomp
  end
end
