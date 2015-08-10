class Xdu < Formula
  # Both homepage & DL-link have been dead for a long time.
  # Switched both to Debian/Ubuntu.
  # homepage "http://sd.wareonearth.com/~phil/xdu/"
  homepage "https://packages.debian.org/source/unstable/xdu"
  url "https://mirrors.kernel.org/debian/pool/main/x/xdu/xdu_3.0.orig.tar.gz"
  mirror "http://archive.ubuntu.com/ubuntu/pool/universe/x/xdu/xdu_3.0.orig.tar.gz"
  sha256 "42c018597e31fade56e44b21ed7041f23756532df6e114b5475b4a50cd4df881"

  depends_on :x11

  def install
    ENV.append_to_cflags "-I#{MacOS::X11.include}"
    ENV.append_to_cflags "-Wno-return-type"
    ENV.append "LDFLAGS", "-L#{MacOS::X11.lib}"
    ENV.append "LDFLAGS", "-lXaw -lXmu -lXt -lSM -lICE -lXpm -lXext -lX11"

    system "#{ENV.cc} -o xdu #{ENV.cflags} #{ENV.ldflags} xdu.c xwin.c"
    bin.install "xdu"
    man1.install "xdu.man" => "xdu.1x"
    (etc/"X11/app-defaults").install "XDu.ad" => "XDu"
  end
end
