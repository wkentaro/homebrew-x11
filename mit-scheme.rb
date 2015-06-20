class MitScheme < Formula
  desc "MIT/GNU Scheme development tools and runtime library"
  homepage "https://www.gnu.org/software/mit-scheme/"
  url "http://ftpmirror.gnu.org/mit-scheme/stable.pkg/9.2/mit-scheme-c-9.2.tar.gz"
  mirror "https://ftp.gnu.org/gnu/mit-scheme/stable.pkg/9.2/mit-scheme-c-9.2.tar.gz"
  sha256 "4f6a16f9c7d4b4b7bb3aa53ef523cad39b54ae1eaa3ab3205930b6a87759b170"
  revision 1

  bottle do
    revision 1
    sha1 "af57614a2fba575d897aead31686ee5cd363fb4f" => :yosemite
    sha1 "7bdca846c5d7efb137b05fa6bff6b755e8eed3fa" => :mavericks
    sha1 "f1c8d3788f6308be61948350ea33dd7ce085307f" => :mountain_lion
  end

  conflicts_with "tinyscheme", :because => "both install a `scheme` binary"

  depends_on "openssl"
  depends_on :x11 => :recommended

  def install
    # The build breaks __HORRIBLY__ with parallel make -- one target will
    # erase something before another target gets it, so it's easier to change
    # the environment than to change_make_var, because there are Makefiles
    # littered everywhere
    ENV.deparallelize

    # Liarc builds must launch within the src dir, not using the top-level
    # Makefile
    cd "src"

    # Take care of some hard-coded paths
    %w[
      6001/edextra.scm
      6001/floppy.scm
      compiler/etc/disload.scm
      edwin/techinfo.scm
      edwin/unix.scm
      microcode/configure
      swat/c/tk3.2-custom/Makefile
      swat/c/tk3.2-custom/tcl/Makefile
      swat/scheme/other/btest.scm
    ].each do |f|
      inreplace f, "/usr/local", prefix
    end

    # The configure script will add "-isysroot" to CPPFLAGS, so it didn't
    # check .h here by default even Homebrew is installed in /usr/local. This
    # breaks things when gdbm or other optional dependencies was installed
    # using Homebrew
    ENV.prepend "CPPFLAGS", "-I#{HOMEBREW_PREFIX}/include"
    ENV["MACOSX_SYSROOT"] = MacOS.sdk_path
    system "etc/make-liarc.sh", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install"
  end

  test do
    # ftp://ftp.cs.indiana.edu/pub/scheme-repository/code/num/primes.scm
    (testpath/"primes.scm").write <<-EOS.undent
      ;
      ; primes
      ; By Ozan Yigit
      ;
      (define  (interval-list m n)
        (if (> m n)
            '()
            (cons m (interval-list (+ 1 m) n))))

      (define (sieve l)
        (define (remove-multiples n l)
          (if (null? l)
        '()
        (if  (= (modulo (car l) n) 0)      ; division test
             (remove-multiples n (cdr l))
             (cons (car l)
             (remove-multiples n (cdr l))))))

        (if (null? l)
            '()
            (cons (car l)
            (sieve (remove-multiples (car l) (cdr l))))))

      (define (primes<= n)
        (sieve (interval-list 2 n)))

      ; (primes<= 300)
    EOS

    output = shell_output(
      "mit-scheme --load primes.scm --eval '(primes<= 72)' < /dev/null"
    )
    assert_match(
      /;Value 2: \(2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71\)/,
      output
    )
  end
end
