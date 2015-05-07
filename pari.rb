class Pari < Formula
  homepage "http://pari.math.u-bordeaux.fr/"
  url "http://pari.math.u-bordeaux.fr/pub/pari/unix/pari-2.7.3.tar.gz"
  mirror "https://mirrors.kernel.org/debian/pool/main/p/pari/pari_2.7.3.orig.tar.gz"
  sha256 "38032944bf4182cecbe438b888ec095ae7768fdbdd2adc1f25251f724f25650a"

  bottle do
    sha1 "279df09e4ed8ef338a908d22b376be54de33900c" => :mavericks
    sha1 "e7fba0b065c31e7f9b23d198f24f76333d28a8ba" => :mountain_lion
    sha1 "8dcd6a003063962867a9f29830acd6eeea58e90f" => :lion
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
