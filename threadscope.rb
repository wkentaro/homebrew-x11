require "language/haskell"

class Threadscope < Formula
  include Language::Haskell::Cabal
  desc "A tool for performance profiling of parallel Haskell programs"
  homepage "https://wiki.haskell.org/ThreadScope"
  url "https://hackage.haskell.org/package/threadscope-0.2.7/threadscope-0.2.7.tar.gz"
  sha256 "cc5653831252d55b3ba7506ea648e770b2c4489cdf4d78828f07dc24ea7ffdb6"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    sha256 "ac75a07f5143b046c8390e58acf0dd10dd2bf7850a4b5602582f0f1b27ba31e7" => :yosemite
    sha256 "adcd744ebdd49521eb0065978db916bd57b617099ce3c9fe65b236b79b411d5b" => :mavericks
    sha256 "75e986926847ba806c046265316b518c8b8f7f14c726df60c7ede053fe82bf3f" => :mountain_lion
  end

  depends_on "cabal-install" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "gettext"
  depends_on "ghc"
  depends_on "glib"
  depends_on "gmp"
  depends_on "gtk+"
  depends_on "pango"

  def install
    cabal_sandbox do
      cabal_install_tools "alex", "happy"
      cabal_install "--only-dependencies", "ghc-events"
      cabal_install "--prefix=#{prefix}", "ghc-events"
      cabal_install_tools "gtk2hs-buildtools"
      cabal_install "glib", "gio", "cairo", "pango"
      cabal_install "-fhave-quartz-gtk", "gtk"
      cabal_install "--only-dependencies"
      cabal_install "--prefix=#{prefix}"
    end
    cabal_clean_lib
  end

  test do
    system "#{bin}/threadscope", "--version"
  end
end
