require "formula"

class SwiProlog < Formula
  homepage "http://www.swi-prolog.org/"
  url "http://www.swi-prolog.org/download/stable/src/swipl-7.2.2.tar.gz"
  sha256 "c137bbe1d652a6aaa003278045e592637cd9fd5f1d52b05f9f0751bfd9449c8d"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    sha256 "449b42660e1b302fb8822288fd7a3882cc6f94b33d329cce66cf84255e99a0a4" => :yosemite
    sha256 "a664d7d4790161fa11aa6de62a463dbad1b7b140507da2ebdfef531437190fcf" => :mavericks
    sha256 "331b630a848d66c9bc4687d5e9c23ff877b5f4e077f2097afd05095eabba8c98" => :mountain_lion
  end

  devel do
    url "http://www.swi-prolog.org/download/devel/src/swipl-7.3.3.tar.gz"
    sha256 "fbdb14d4b780f210feb9a3656fb8fabcc2f8aa95d172b1cf2847189e2bd7df6f"
  end

  head do
    url "https://github.com/SWI-Prolog/swipl-devel.git"

    depends_on "autoconf" => :build
  end

  option "lite", "Disable all packages"
  option "with-jpl", "Enable JPL (Java Prolog Bridge)"
  option "with-xpce", "Enable XPCE (Prolog Native GUI Library)"

  depends_on "pkg-config" => :build
  depends_on "readline"
  depends_on "gmp"
  depends_on "openssl"
  depends_on "libarchive" => :optional

  if build.with? "xpce"
    depends_on :x11
    depends_on "jpeg"
  end

  # 10.5 versions of these are too old
  if MacOS.version <= :leopard
    depends_on "fontconfig"
    depends_on "expat"
  end

  fails_with :llvm do
    build 2335
    cause "Exported procedure chr_translate:chr_translate_line_info/3 is not defined"
  end

  def install
    # The archive package hard-codes a check for MacPort libarchive
    # Replace this with a check for Homebrew's libarchive, or nowhere
    if build.with? "libarchive"
      inreplace "packages/archive/configure.in", "/opt/local",
                                                 Formula["libarchive"].opt_prefix
    else
      ENV.append "DISABLE_PKGS", "archive"
    end

    args = ["--prefix=#{libexec}", "--mandir=#{man}"]
    ENV.append "DISABLE_PKGS", "jpl" if build.without? "jpl"
    ENV.append "DISABLE_PKGS", "xpce" if build.without? "xpce"

    # SWI-Prolog's Makefiles don't add CPPFLAGS to the compile command, but do
    # include CIFLAGS. Setting it here. Also, they clobber CFLAGS, so including
    # the Homebrew-generated CFLAGS into COFLAGS here.
    ENV["CIFLAGS"] = ENV.cppflags
    ENV["COFLAGS"] = ENV.cflags

    # Build the packages unless --lite option specified
    args << "--with-world" unless build.include? "lite"

    # './prepare' prompts the user to build documentation
    # (which requires other modules). '3' is the option
    # to ignore documentation.
    system "echo '3' | ./prepare" if build.head?
    system "./configure", *args
    system "make"
    system "make install"

    bin.write_exec_script Dir["#{libexec}/bin/*"]
  end

  test do
    system "#{bin}/swipl", "--version"
  end
end
