class I3 < Formula
  desc "Tiling window manager"
  homepage "http://i3wm.org/"
  url "http://i3wm.org/downloads/i3-4.11.tar.bz2"
  sha256 "78ce1e06fbd92fd63765bbe23faa7b8f929c17f99ed623f7abf2e568169d982f"
  head "https://github.com/i3/i3.git"

  bottle do
    revision 1
    sha256 "30a52f1ca46e476cb97f87db7192e56009edd308dab52b4b6590ccb90a4afd5a" => :el_capitan
    sha256 "6f97e6ffd04dd9cb92735087cbc1d6e7b1ae621c20be10af29f17b44e99af577" => :yosemite
    sha256 "8f28ab83eaffec56f5ff46d63ac7c188be4485839bea5ea764bc1c273de756f9" => :mavericks
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
    man1.install Dir["man/*.1"]
  end

  test do
    result = shell_output("#{bin}/i3 -v")
    result.force_encoding("UTF-8") if result.respond_to?(:force_encoding)
    assert_match /#{version}/, result
  end
end
