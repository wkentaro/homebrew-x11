class I3 < Formula
  desc "Tiling window manager"
  homepage "http://i3wm.org/"
  url "http://i3wm.org/downloads/i3-4.11.tar.bz2"
  sha256 "78ce1e06fbd92fd63765bbe23faa7b8f929c17f99ed623f7abf2e568169d982f"
  head "https://github.com/i3/i3.git"

  bottle do
    sha256 "f21e0d93c9b0795dd1ea82ce35416234ca2e7a9dada7e8b61651b52292aab7b0" => :el_capitan
    sha256 "0b108625e7b874d49fd37f87f08203b134f29482f7572cbb6bb5bef176b3b695" => :yosemite
    sha256 "ead1ac03f314ab8b8105dbd79a5d30dfd24ffceb635600026080371774738e38" => :mavericks
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
