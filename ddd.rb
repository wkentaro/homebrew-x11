require 'formula'

class Ddd < Formula
  homepage 'http://www.gnu.org/s/ddd/'
  url 'http://ftpmirror.gnu.org/ddd/ddd-3.3.12.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/ddd/ddd-3.3.12.tar.gz'
  sha1 'b91d2dfb1145af409138bd34517a898341724e56'
  revision 1

  bottle do
    sha256 "10fadf3297a98b3682f312594a67707f78b6feee6f8ddfa616f4943bd2f5e222" => :yosemite
    sha256 "e35574c21a4cd7192596d676e79029964482f623ecaac9372e666f79b276263a" => :mavericks
    sha256 "faea737b1f709c7d1a068c34a37a6f13a5c23fc7bf3e3fc6149479014c7c132b" => :mountain_lion
  end

  depends_on 'openmotif'
  depends_on :x11

  # Needed for OSX 10.9 DP6 build failure:
  # https://savannah.gnu.org/patch/?8178
  patch :p0 do
    url "https://savannah.gnu.org/patch/download.php?file_id=29114"
    sha1 "4f7406e7698f54f609ced955f0cc90374cc45431"
  end if MacOS.version >= :mavericks

  # https://savannah.gnu.org/bugs/?41997
  patch do
    url "https://savannah.gnu.org/patch/download.php?file_id=31132"
    sha1 "a004e64cbfa46333b3bba1a910a4f4e9049dc5d2"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-builtin-app-defaults",
                          "--enable-builtin-manual",
                          "--prefix=#{prefix}"

    # From MacPorts:
    # make will build the executable "ddd" and the X resource file "Ddd" in the same directory,
    # as HFS+ is case-insensitive by default, this will loosely FAIL
    system "make EXEEXT=exe"

    ENV.deparallelize
    system "make install EXEEXT=exe"

    mv bin/'dddexe', bin/'ddd'
  end
end
