class Yarp < Formula
  desc "Yet Another Robot Platform"
  homepage "http://yarp.it"
  url "https://github.com/robotology/yarp/archive/v2.3.64.tar.gz"
  sha256 "3882b38c39ec9c5fdd06c68f3a4ad21da718bd2733ed7d6a5fb78d9f36dad6b2"
  head "https://github.com/robotology/yarp.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    revision 1
    sha256 "de4e5f034538991b5184c7030f79a44cb4bd76f7d4cbd2385c9e4141ea44803a" => :yosemite
    sha256 "658267b21ae11c68b5247c8826f2cf5ad504791d16e1eeee445801294410bc92" => :mavericks
    sha256 "23dc0cb343be352df00207063314257f8c3eef8ee4f4622005f5183423799d8d" => :mountain_lion
  end

  option "with-qt5", "Build the Qt5 GUI applications"
  option "with-yarprun-log", "Build with yarprun_log support"
  option "with-opencv", "Build the opencv_grabber device"
  option "with-lua", "Build with Lua bindings"
  option "with-serial", "Build the serial/serialport devices"

  depends_on "pkg-config" => :build
  depends_on "cmake" => :build
  depends_on "ace"
  depends_on "gsl"
  depends_on "sqlite"
  depends_on "readline"
  depends_on "jpeg"
  depends_on "homebrew/science/opencv" => :optional
  depends_on "qt5" => :optional
  depends_on "lua" => :optional
  depends_on "swig" if build.with? "lua"

  def install
    args = std_cmake_args + %W[
      -DCREATE_LIB_MATH=TRUE
      -DCREATE_DEVICE_LIBRARY_MODULES=TRUE
      -DCREATE_OPTIONAL_CARRIERS=TRUE
      -DENABLE_yarpcar_mjpeg_carrier=TRUE
      -DENABLE_yarpcar_rossrv_carrier=TRUE
      -DENABLE_yarpcar_tcpros_carrier=TRUE
      -DENABLE_yarpcar_xmlrpc_carrier=TRUE
      -DENABLE_yarpcar_bayer_carrier=TRUE
      -DENABLE_yarpcar_priority_carrier=TRUE
      -DCREATE_IDLS=TRUE
    ]

    args << "-DCREATE_GUIS=TRUE" if build.with? "qt5"
    args << "-DENABLE_YARPRUN_LOG=ON" if build.with? "yarprun-log"
    args << "-DENABLE_yarpmod_opencv_grabber=ON" if build.with? "opencv"

    if build.with? "lua"
      args << "-DYARP_COMPILE_BINDINGS=ON"
      args << "-DCREATE_LUA=ON"
    end

    if build.with? "serial"
      args << "-DENABLE_yarpmod_serial=ON"
      args << "-DENABLE_yarpmod_serialport=ON"
    end

    system "cmake", *args
    system "make", "install"
    bash_completion.install "scripts/yarp_completion"
  end

  def caveats
    <<-EOS.undent
    You need to add in your ~/.bash_profile or similar:

      export YARP_DATA_DIRS=#{HOMEBREW_PREFIX}/share/yarp
    EOS
  end

  test do
    system "#{bin}/yarp", "check"
  end
end
