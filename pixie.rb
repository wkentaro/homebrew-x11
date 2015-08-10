class Pixie < Formula
  homepage "http://www.renderpixie.com/"
  url "https://downloads.sourceforge.net/project/pixie/pixie/Pixie%202.2.6/Pixie-src-2.2.6.tgz"
  sha256 "ffbbc404265aff3d4c0303ec91549708ffba8edefc0368ac119ae2e588f35037"
  revision 1

  depends_on "libtiff"
  depends_on "fltk"
  depends_on "openexr"
  depends_on "libpng"
  depends_on :x11

  def install
    openexr = Formula["openexr"]
    ilmbase = Formula["ilmbase"]

    ENV.append "CPPFLAGS", "-I#{openexr.include}/OpenEXR -I#{ilmbase.include}/OpenEXR"
    ENV.append "LDFLAGS",  "-L#{openexr.lib} -L#{ilmbase.lib}"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-openexr-prefix=#{openexr.prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/rndr", "-v"
  end
end
