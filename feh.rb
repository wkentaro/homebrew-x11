class Feh < Formula
  homepage "http://feh.finalrewind.org/"
  url "http://feh.finalrewind.org/feh-2.12.1.tar.bz2"
  sha256 "9026ece01d79560e1eff9715fa1765eef82e22c766da5994ee787984a6f466a1"

  depends_on :x11
  depends_on "imlib2"
  depends_on "libexif" => :recommended

  def install
    args = []
    args << "exif=1" if build.with? "libexif"
    system "make", "PREFIX=#{prefix}", *args
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system bin/"feh", "-v"
  end
end
