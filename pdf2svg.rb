class Pdf2svg < Formula
  desc "PDF converter to SVG"
  homepage "http://www.cityinthesky.co.uk/opensource/pdf2svg"
  url "https://github.com/db9052/pdf2svg/archive/v0.2.3.tar.gz"
  sha256 "4fb186070b3e7d33a51821e3307dce57300a062570d028feccd4e628d50dea8a"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    cellar :any
    sha256 "41ab99882a3ff083b07f7026cb9377ca07b6d5937a69b3430036d5bf7a12cd41" => :yosemite
    sha256 "e3a9d5720c40c9ec76723df065c1f82aef70a5aaf1980ac6166df44dd111f1a4" => :mavericks
    sha256 "9bfc28821286439d4adcc1d55be1c8a71e9cc2aa209468b9cfefd09112fd87ef" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "poppler"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    curl "-O", "http://partners.adobe.com/public/developer/en/xml/AdobeXMLFormsSamples.pdf"
    system "#{bin}/pdf2svg", "AdobeXMLFormsSamples.pdf", "test.svg"
  end
end
