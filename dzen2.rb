class Dzen2 < Formula
  homepage "http://sites.google.com/site/gotmor/dzen"
  url "http://sites.google.com/site/gotmor/dzen2-0.8.5.tar.gz"
  sha256 "5e4ce96e8ed22a4a0ad6cfafacdde0532d13d049d77744214b196c4b2bcddff9"

  depends_on :x11

  def install
    ENV.append "LDFLAGS", "-lX11 -lXinerama -lXpm"
    ENV.append_to_cflags '-DVERSION=\"${VERSION}\" -DDZEN_XINERAMA -DDZEN_XPM'

    inreplace "config.mk" do |s|
      s.change_make_var! "PREFIX", prefix
      s.change_make_var! "CC", ENV.cc
      s.change_make_var! "CFLAGS", ENV.cflags
      s.change_make_var! "LDFLAGS", ENV.ldflags
    end

    system "make", "install"
  end
end
