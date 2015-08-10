class Atarixx < Formula
  homepage "http://www.xl-project.com"
  url "http://www.xl-project.com/download/atari++_1.72.tar.gz"
  sha256 "66c530896f87f53e0a450f9e0c659a4f01045177f6a81d8abb2f5bb42733dc48"

  option "with-curses"

  depends_on :x11
  depends_on "sdl" => :recommended

  def install
    args = ["--prefix=#{prefix}"]
    args << "--disable-CURSES" if build.without? "curses"
    args << "--disable-SDL" if build.without? "sdl"

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
