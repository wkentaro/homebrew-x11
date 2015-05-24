class Fox < Formula
  homepage "http://www.fox-toolkit.org/"
  url "http://ftp.fox-toolkit.org/pub/fox-1.6.50.tar.gz"
  sha256 "342c751d2a7edab136ad26cb4483329da3c16c7abf2f283f318d666ef12d0887"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    cellar :any
    sha256 "f7e8e7b4ecc4e9cb469b909427adea9ccf72a59c3f89ffd6ea6b006839c6c208" => :yosemite
    sha256 "369b4d8ef5f2dc7e0afae6aa465140c1617d7fb48a14eafd3234974ac3e1ffe0" => :mavericks
    sha256 "08c75fa15ea4146a0fed0e417060a9faf82374884c32d6b0eba226bddf0ece58" => :mountain_lion
  end

  # Development and stable branches are incompatible
  devel do
    url "http://ftp.fox-toolkit.org/pub/fox-1.7.50.tar.gz"
    sha256 "cdc432807f047b312ab54a778dc898e429dcfecf513fe0d350a7952f523a71df"
  end

  depends_on :x11
  depends_on "freetype"
  depends_on "libpng"
  depends_on "jpeg"
  depends_on "libtiff"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--enable-release",
                          "--prefix=#{prefix}",
                          "--with-x",
                          "--with-opengl"
    # Unset LDFLAGS, "-s" causes the linker to crash
    system "make", "install", "LDFLAGS="
    rm bin/"Adie.stx"
  end

  test do
    system bin/"reswrap", "-t",
           "-o", testpath/"text.txt",
           test_fixtures("test.jpg")
    assert_match "\\x00\\x85\\x80\\x0f\\xae\\x03\\xff\\xd9",
                 (testpath/"text.txt").read
  end
end
