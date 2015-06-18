class Pdf2svg < Formula
  desc "PDF converter to SVG"
  homepage "http://www.cityinthesky.co.uk/opensource/pdf2svg"
  url "http://www.cityinthesky.co.uk/wp-content/uploads/2013/10/pdf2svg-0.2.2.tar.gz"
  sha256 "c2a29cc81d01fea220523abad39c400e9c5411b395b6ba3ccbedb4cd398ec6cb"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    cellar :any
    sha256 "41ab99882a3ff083b07f7026cb9377ca07b6d5937a69b3430036d5bf7a12cd41" => :yosemite
    sha256 "e3a9d5720c40c9ec76723df065c1f82aef70a5aaf1980ac6166df44dd111f1a4" => :mavericks
    sha256 "9bfc28821286439d4adcc1d55be1c8a71e9cc2aa209468b9cfefd09112fd87ef" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cairo"
  depends_on "poppler"

  # build script contains mandatory dependency on Gtk+ which is used nowhere by the code
  # this patch removes all references to Gtk+
  # issue filed upstream: https://github.com/db9052/pdf2svg/issues/7
  patch :DATA

  def install
    touch("README")
    system "autoreconf", "-i", "-f"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    curl "-O", "http://partners.adobe.com/public/developer/en/xml/AdobeXMLFormsSamples.pdf"
    system "#{bin}/pdf2svg", "AdobeXMLFormsSamples.pdf", "test.svg"
  end
end
__END__
diff --git a/Makefile.am b/Makefile.am
index b8e7747..0c1ac38 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -14,7 +14,7 @@ bin_PROGRAMS = pdf2svg
 # N.B. POPPLERGLIB_ should be set by the configure script either using pkg-config,
 # by guessing where the librarys may be, or by the user specifying.
 pdf2svg_SOURCES = pdf2svg.c
-pdf2svg_CFLAGS = $(CAIRO_CFLAGS) $(GTK2_CFLAGS) $(POPPLERGLIB_CFLAGS)
-pdf2svg_LDADD = $(CAIRO_LIBS) $(GTK2_LIBS) $(POPPLERGLIB_LIBS)
+pdf2svg_CFLAGS = $(CAIRO_CFLAGS) $(POPPLERGLIB_CFLAGS)
+pdf2svg_LDADD = $(CAIRO_LIBS) $(POPPLERGLIB_LIBS)

-MAINTAINERCLEANFILES = Makefile.in
\ No newline at end of file
+MAINTAINERCLEANFILES = Makefile.in
diff --git a/configure.ac b/configure.ac
index 5b9bcc2..9acf2cc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -20,8 +20,6 @@ AC_C_CONST
 PKG_CHECK_MODULES(CAIRO,cairo >= 1.2.6)
 # Use pkg-config to check for the existence of the poppler-glib libraries
 PKG_CHECK_MODULES(POPPLERGLIB,poppler-glib >= 0.5.4)
-# GTK
-PKG_CHECK_MODULES(GTK2,gtk+-2.0)

 # Generate the Makefile
 AC_CONFIG_FILES([Makefile])
