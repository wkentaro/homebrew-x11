class Pari < Formula
  homepage "http://pari.math.u-bordeaux.fr/"
  url "http://pari.math.u-bordeaux.fr/pub/pari/unix/pari-2.7.3.tar.gz"
  mirror "https://mirrors.kernel.org/debian/pool/main/p/pari/pari_2.7.3.orig.tar.gz"
  sha256 "38032944bf4182cecbe438b888ec095ae7768fdbdd2adc1f25251f724f25650a"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    sha256 "117b68816bcec0e692ae9517639a327de286eb43afc9d517e84c59fbb46cd55a" => :yosemite
    sha256 "4e1b7bdb62f7ace93e4b12cfe0a4eed16e185fedee35f62350969081d4d589dc" => :mavericks
    sha256 "64fc709bb96c40dd1a17dbc9695a51f33fc9e8112e34180ce016364c471e17e6" => :mountain_lion
  end

  depends_on "gmp"
  depends_on "readline"
  depends_on :x11

  def install
    readline = Formula["readline"].opt_prefix
    gmp = Formula["gmp"].opt_prefix
    system "./Configure", "--prefix=#{prefix}",
                          "--with-gmp=#{gmp}",
                          "--with-readline=#{readline}"
    # make needs to be done in two steps
    system "make", "all"
    system "make", "install"
  end

  test do
    (testpath/"math.tex").write "$k_{n+1} = n^2 + k_n^2 - k_{n-1}$"
    system bin/"tex2mail", testpath/"math.tex"
  end
end
