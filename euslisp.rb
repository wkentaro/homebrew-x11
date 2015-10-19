class Euslisp < Formula
  desc "Integrated programming system for research on robots"
  homepage "https://github.com/euslisp/EusLisp"
  url "https://github.com/euslisp/EusLisp/archive/EusLisp-9.15.tar.gz"
  sha256 "74cf37606bd9fcb38ddcd6dcfbbb0989375faa9c18ada3dff6e39d610d966ea9"
  head "https://github.com/euslisp/EusLisp.git"

  bottle do
    cellar :any
    sha256 "d2845cb15b3ebe56a81177b3bd01a8f29fa5a4e7694fa2030ae7c97df24aa331" => :el_capitan
    sha256 "be84cea05d002bbea94cc676fb741e6eda7f0df1638bc061066f8059d3679a26" => :yosemite
    sha256 "a69ac245ae76d79c5d9787d6384f85ebc2127ce6a6bbe8c844dda6f38f2d2805" => :mavericks
  end

  depends_on :x11

  def install
    ENV.deparallelize
    ENV.O0

    # euslisp needs to be compiled in Cellar
    cp_r buildpath, "#{prefix}/eus"

    cd "#{prefix}/eus" do
      ENV["ARCHDIR"] = "Darwin"
      ENV["EUSDIR"] = Dir.pwd
      ENV.prepend_path "PATH", prefix/"Darwin/bin"
      ENV.prepend_path "LD_LIBRARY_PATH", prefix/"Darwin/lib"

      cd "lisp" do
        ln_s "Makefile.Darwin", "Makefile"
        system "make"

        bin.mkpath
        system "make", "install", "PUBBINDIR=#{bin}"
      end
    end
  end

  def caveats; <<-EOF.undent
    Please add below lines to your shell configuration file. (ex. ~/.bashrc or ~/.zshrc)
    export EUSDIR=#{opt_prefix}/eus
    EOF
  end

  test do
    ENV["EUSDIR"] = "#{opt_prefix}/eus"
    system "#{bin}/eus", "(exit)"
  end
end
