class Euslisp < Formula
  desc "Integrated programming system for research on robots"
  homepage "https://github.com/euslisp/EusLisp"
  url "https://github.com/euslisp/EusLisp/archive/EusLisp-9.15.tar.gz"
  sha256 "74cf37606bd9fcb38ddcd6dcfbbb0989375faa9c18ada3dff6e39d610d966ea9"
  head "https://github.com/euslisp/EusLisp.git"
  revision 1

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

        libexec.mkpath
        system "make", "install", "PUBBINDIR=#{libexec}"
      end
    end

    bin.mkpath
    ["eus", "eusx", "euscomp"].each do |exec|
      (bin/exec).write <<-EOS.undent
        #!/bin/bash
        EUSDIR=#{opt_prefix}/eus ARCHDIR=Darwin LD_LIBRARY_PATH=$EUSDIR/$ARCHDIR/bin:$LD_LIBRARY_PATH exec #{libexec}/#{exec} "$@"
      EOS
    end
  end

  test do
    system "#{bin}/eus", "(exit)"
    system "#{bin}/eusx", "(exit)"
    system "#{bin}/euscomp", "(exit)"
  end
end
