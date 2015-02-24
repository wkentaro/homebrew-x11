require 'formula'

class Scantailor < Formula
  class Version < ::Version
    def enhanced?
      to_s.start_with?("enhanced")
    end

    def <=>(other)
      other = self.class.new(other)
      if enhanced? && other.enhanced?
        super
      elsif enhanced?
        1
      elsif other.enhanced?
        -1
      else
        super
      end
    end
  end

  homepage 'http://scantailor.org/'
  url 'https://downloads.sourceforge.net/project/scantailor/scantailor/0.9.11.1/scantailor-0.9.11.1.tar.gz'
  version Scantailor::Version.new("0.9.11.1")
  sha1 '80970bbcd65fbf8bc62c0ff0cb7bcb78c86961c3'

  devel do
    url 'https://downloads.sourceforge.net/project/scantailor/scantailor-devel/enhanced/scantailor-enhanced-20140214.tar.bz2'
    version Scantailor::Version.new("enhanced-20140214")
    sha1 'e90b861f02a571184b8ab9d5ef59dd57dcf1c212'
  end

  depends_on 'cmake' => :build
  depends_on 'qt'
  depends_on 'boost'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on :x11

  # Makes Scan Tailor work with Clang on OS X Mavericks
  # Approved by maintainer and included in official repository.
  # See: http://sourceforge.net/p/scantailor/mailman/message/31884956/
  patch do
    url "https://gist.githubusercontent.com/muellermartin/8569243/raw/b09215037b346787e0f501ae60966002fd79602e/scantailor-0.9.11.1-clang.patch"
    sha1 "4594b28bcf9409ef252638830c633dd42c63bc40"
  end

  # Hides Boost headers from Qt's moc tool.
  # Result of perl -ni -e '$b=m/include.*boost/; print "#ifndef Q_MOC_RUN\n" if $b; print $_; print "#endif\n" if $b;' **/*.{h,cpp}
  # https://bugreports.qt.io/browse/QTBUG-22829
  stable do
    patch do
      url "https://gist.githubusercontent.com/jkseppan/ccf72d14f8b0efee6c7d/raw/dc97fbeb6b086a44c75b857a0f31e7a4f2adcdda/scantailor-0.9.11.1-moc-boost.patch"
      sha1 "955227c27588db36e8198a9e55c536116c82044d"
    end
  end
  devel do
    patch do
      url "https://gist.githubusercontent.com/jkseppan/836934647cca55eba855/raw/eff85dafc5a0fdc62859f106ffffac28eba38d93/scantailor-enhanced-20140214-moc-boost.patch"
      sha1 "4d143ca7ba2018ef9ee683d1c2da09b3658b5c26"
    end
  end

  # Changes some uses of boost::lambda::bind to C++11 lambdas.
  # Avoids compilation errors with Boost 1.57.
  # https://github.com/scantailor/scantailor/issues/125
  patch do
    url "https://gist.githubusercontent.com/jkseppan/49901ece3da6a0604887/raw/32a273bec2d20c2c70e8b789616f93590af6a4b1/scantailor-enhanced-20140214-c++11.patch"
    sha1 "3a4373f006de5640087182d7bb4f0e1cb9cc2c56"
  end

  def install
    system "cmake", ".", "-DPNG_INCLUDE_DIR=#{MacOS::X11.include}", "-DCMAKE_CXX_FLAGS=-std=c++11 -stdlib=libc++", *std_cmake_args
    system "make install"
  end
end
