class Bochs < Formula
  homepage "http://bochs.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/bochs/bochs/2.6.7/bochs-2.6.7.tar.gz"
  sha256 "a4354eeb699662da869b038e225160ec726b883f1b4f425a06cf56cbffbb8282"

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
