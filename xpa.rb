class Xpa < Formula
  homepage "http://hea-www.harvard.edu/RD/xpa/"
  url "http://hea-www.harvard.edu/saord/download/xpa/xpa-2.1.15.tar.gz"
  sha256 "ac0e041f9115757fbcbfeb377cb5833544815a70f2b46f6edfbf6d1239ae690a"

  depends_on :x11

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"

    # relocate man, since --mandir is ignored
    mv "#{prefix}/man", man
  end
end
