class Bochs < Formula
  homepage "http://bochs.sourceforge.net/"
  desc "A highly portable open source IA-32 (x86) PC emulator written in C++"
  url "https://downloads.sourceforge.net/project/bochs/bochs/2.6.8/bochs-2.6.8.tar.gz"
  sha256 "79700ef0914a0973f62d9908ff700ef7def62d4a28ed5de418ef61f3576585ce"

  bottle do
    sha256 "9efec04a05953eeb5a385b28ed1c8a2202e13bedcfcee3933baf32cf1eadfe80" => :yosemite
    sha256 "43d3b3d637710ea229ef456716bc3b126e32d19e6b653ec4d4e061100e79af34" => :mavericks
    sha256 "34a83396abc3570523eb4ea9d70d33dba353097228d03de7f5879af83a15443a" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on :x11
  depends_on "gtk+"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--with-x11",
                          "--enable-debugger",
                          "--enable-disasm",
                          "--disable-docbook",
                          "--enable-x86-64",
                          "--enable-pci",
                          "--enable-all-optimizations",
                          "--enable-plugins",
                          "--enable-cdrom",
                          "--enable-a20-pin",
                          "--enable-fpu",
                          "--enable-alignment-check",
                          "--enable-large-ramfile",
                          "--enable-debugger-gui",
                          "--enable-readline",
                          "--enable-iodebug",
                          "--enable-xpm",
                          "--enable-show-ips",
                          "--enable-logging",
                          "--enable-usb",
                          "--enable-ne2000",
                          "--enable-cpu-level=6",
                          "--enable-sb16",
                          "--enable-clgd54xx",
                          "--with-term",
                          "--enable-ne2000"

    system "make"
    system "make", "install"
  end

  test do
    system bin/"bochs", "--help"
  end
end
