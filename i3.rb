class I3 < Formula
  desc "Tiling window manager"
  homepage "http://i3wm.org/"
  url "http://i3wm.org/downloads/i3-4.10.2.tar.bz2"
  sha256 "0795a31b47f93b637da7f7e65197568117f46a35c745f4de4f56e7b2efcccfd8"
  head "https://github.com/i3/i3.git"

  depends_on "asciidoc" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo"
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
