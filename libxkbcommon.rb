class Libxkbcommon < Formula
  desc "Keyboard handling library"
  homepage "http://xkbcommon.org/"
  url "http://xkbcommon.org/download/libxkbcommon-0.5.0.tar.xz"
  sha256 "90bd7824742b9a6f52a6cf80e2cadd6f5349cf600a358d08260772615b89d19c"
  head "https://github.com/xkbcommon/libxkbcommon.git"

  depends_on :x11
  depends_on "bison" => :build
  depends_on "pkg-config" => :build

  def install
    inreplace "configure" do |s|
      s.gsub! "-version-script $output_objdir/$libname.ver", ""
      s.gsub! "${wl}-version-script", ""
    end
    inreplace %w[Makefile.in Makefile.am] do |s|
      s.gsub! "-Wl,--version-script=${srcdir}/xkbcommon.map", ""
      s.gsub! "-Wl,--version-script=${srcdir}/xkbcommon-x11.map", ""
    end

    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
    #include <stdlib.h>
    #include <xkbcommon/xkbcommon.h>
    int main() {
      return (xkb_context_new(XKB_CONTEXT_NO_FLAGS) == NULL)
             ? EXIT_FAILURE
             : EXIT_SUCCESS;
    }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lxkbcommon", "-o", "test"
    system "./test"
  end
end
