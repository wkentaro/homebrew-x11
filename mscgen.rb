class Mscgen < Formula
  homepage "http://www.mcternan.me.uk/mscgen/"
  url "http://www.mcternan.me.uk/mscgen/software/mscgen-src-0.20.tar.gz"
  sha256 "3c3481ae0599e1c2d30b7ed54ab45249127533ab2f20e768a0ae58d8551ddc23"

  depends_on :x11
  depends_on "pkg-config" => :build
  depends_on "gd" => :recommended
  depends_on "freetype" => :optional

  def install
    args = ["--prefix=#{prefix}",
            "--disable-dependency-tracking"]

    args << "--with-freetype" if build.with? "freetype"

    system "./configure", *args
    system "make", "install"
  end
end
