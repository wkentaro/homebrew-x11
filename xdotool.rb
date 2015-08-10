class Xdotool < Formula
  homepage "http://www.semicomplete.com/projects/xdotool/"
  url "https://semicomplete.googlecode.com/files/xdotool-2.20110530.1.tar.gz"
  sha256 "e7b42c8b1d391970e1c1009b256033f30e57d8e0a2a3de229fd61ecfc27baf67"

  depends_on "pkg-config" => :build

  depends_on :x11

  def install
    system "make", "PREFIX=#{prefix}", "INSTALLMAN=#{man}", "install"
  end

  def caveats; <<-EOS.undent
    You will probably want to enable XTEST in your X11 server now by running:
      defaults write org.x.X11 enable_test_extensions -boolean true

    For the source of this useful hint:
      http://stackoverflow.com/questions/1264210/does-mac-x11-have-the-xtest-extension
    EOS
  end
end
