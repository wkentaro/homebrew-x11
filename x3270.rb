class X3270 < Formula
  homepage "http://x3270.bgp.nu/"
  url "https://downloads.sourceforge.net/project/x3270/x3270/3.4ga8/suite3270-3.4ga8-src.tgz"
  sha256 "06be4d79ffc24f4465b167b08c6ec48b595f689f3c5177ce5902fb31560b5dfd"

  bottle do
    sha256 "5263d9ff0056e64d37d7a47503a6806265a59196800d231ae51c5d6c5a268b78" => :el_capitan
    sha256 "68970da1b71f3355b11e541c401501c51483abcddcd3e288ddfd2143958e5225" => :yosemite
    sha256 "8d3305ecc979f02af1795310f979358b695ac9462b6aa1aa2f9fb7aedb574992" => :mavericks
  end

  depends_on :x11
  depends_on "openssl"

  option "with-c3270", "Include c3270 (curses-based version)"
  option "with-s3270", "Include s3270 (displayless version)"
  option "with-tcl3270", "Include tcl3270 (integrated with Tcl)"
  option "with-pr3287", "Include pr3287 (printer emulation)"

  def install
    args = ["--prefix=#{prefix}"]
    args << "--enable-x3270"
    args << "--enable-c3270" if build.with? "c3270"
    args << "--enable-s3270" if build.with? "s3270"
    args << "--enable-tcl3270" if build.with? "tcl3270"
    args << "--enable-pr3287" if build.with? "pr3287"

    system "./configure", *args
    system "make", "install"
    system "make", "install.man"
  end

  test do
    system bin/"x3270", "--version"
  end
end
