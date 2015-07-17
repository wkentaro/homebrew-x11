class Grace < Formula
  homepage "http://plasma-gate.weizmann.ac.il/Grace/"
  url "https://mirrors.kernel.org/debian/pool/main/g/grace/grace_5.1.25.orig.tar.gz"
  sha256 "751ab9917ed0f6232073c193aba74046037e185d73b77bab0f5af3e3ff1da2ac"
  revision 1

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    sha256 "c43911a967268be84fcc6c63c95d7c31dceaa86bae27e93717c486ecad2b5a56" => :yosemite
    sha256 "31d319f10c0416849a1e7dc408cde9f9025cf594ee9f9e4d07eef80177d9fc48" => :mavericks
    sha256 "b0cd52ba67d4e68939b5dcb55993d74faa934a935c5c50e638610d6371105bc8" => :mountain_lion
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
