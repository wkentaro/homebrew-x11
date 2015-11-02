class I3 < Formula
  desc "Tiling window manager"
  homepage "http://i3wm.org/"
  url "http://i3wm.org/downloads/i3-4.11.tar.bz2"
  sha256 "78ce1e06fbd92fd63765bbe23faa7b8f929c17f99ed623f7abf2e568169d982f"
  head "https://github.com/i3/i3.git"

  bottle do
    sha256 "34c0231d90b89dd1f2a43f12289226e14c15a88f45f860986773a94f9f5566ad" => :yosemite
    sha256 "8254be976fa8a5f3e5dc0d041d3f81cf9e750299e636a3aaa947d13811fde7ae" => :mavericks
    sha256 "a91d897fc0387b6484d17dff360f8427cdd6b98383a308056efeb615f0663788" => :mountain_lion
  end

  depends_on "asciidoc" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo" => ["with-x11"]
  depends_on "gettext"
  depends_on "libev"
  depends_on "pango"
  depends_on "pcre"
  depends_on "startup-notification"
  depends_on "yajl"
  depends_on :x11
  depends_on "libxkbcommon"

  def install
    # In src/i3.mk, precompiled headers are used if CC=clang, however superenv
    # currently breaks the clang invocation, setting CC=cc works around this.
    system "make", "install", "CC=cc", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/i3", "-v"
  end
end
