class Xclip < Formula
  homepage "http://xclip.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/xclip/xclip/0.12/xclip-0.12.tar.gz"
  sha256 "b7c7fad059ba446df5692d175c2a1d3816e542549661224806db369a0d716c45"

  depends_on :x11

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/xclip", "-version"
  end
end
