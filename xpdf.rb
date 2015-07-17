class Xpdf < Formula
  homepage "http://www.foolabs.com/xpdf/"
  url "ftp://ftp.foolabs.com/pub/xpdf/xpdf-3.04.tar.gz"
  sha256 "11390c74733abcb262aaca4db68710f13ffffd42bfe2a0861a5dfc912b2977e5"
  revision 1

  bottle do
    sha256 "da1db4af229f785317209a44b6e23f37988a8611fb10a8f75cd4ab626b5a4e08" => :yosemite
    sha256 "c68ef386a3d9c60cf751086d13a6c9ad03e441b841ebac25a15f59cafd7ead89" => :mavericks
    sha256 "76c1f24fc404ee277023d3c488180fdc5a0b9e4c8fc18092a7318121375ea3d0" => :mountain_lion
  end

  depends_on "openmotif"
  depends_on "freetype"
  depends_on :x11

  conflicts_with "pdf2image", "poppler",
    :because => "xpdf, pdf2image, and poppler install conflicting executables"

  def install
    freetype = Formula["freetype"]
    openmotif = Formula["openmotif"]
    system "./configure", "--prefix=#{prefix}",
                          "--with-freetype2-library=#{freetype.opt_lib}",
                          "--with-freetype2-includes=#{freetype.opt_include}/freetype2",
                          "--with-Xm-library=#{openmotif.opt_lib}",
                          "--with-Xm-includes=#{openmotif.opt_include}",
                          "--with-Xpm-library=#{MacOS::X11.lib}",
                          "--with-Xpm-includes=#{MacOS::X11.include}",
                          "--with-Xext-library=#{MacOS::X11.lib}",
                          "--with-Xext-includes=#{MacOS::X11.include}",
                          "--with-Xp-library=#{MacOS::X11.lib}",
                          "--with-Xp-includes=#{MacOS::X11.include}",
                          "--with-Xt-library=#{MacOS::X11.lib}",
                          "--with-Xt-includes=#{MacOS::X11.include}"
    system "make"
    system "make", "install"
  end
end
