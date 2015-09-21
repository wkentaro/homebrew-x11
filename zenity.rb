class Zenity < Formula
  desc "GTK+ dialog boxes for the command-line"
  homepage "https://live.gnome.org/Zenity"
  url "https://download.gnome.org/sources/zenity/3.18/zenity-3.18.0.tar.xz"
  sha256 "0efafea95a830f3bf6eca805ff4a8008df760a6ad3e81181b9473dcf721c3a69"

  bottle do
    sha256 "105cbdb34aaafe239277e926c7892aa636a20ccb611013c8fe662fd649286423" => :yosemite
    sha256 "12e5b7d3c268e057460a5e3656e5cb02519172e8b5fc05f1fa92457d8c29e095" => :mavericks
    sha256 "d5a679656230f98c0f642d2825a82f4cb8e912f90fe68f6c78ceef993649131c" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "itstool" => :build
  depends_on "libxml2"
  depends_on "gtk+3"
  depends_on "gnome-doc-utils"
  depends_on "scrollkeeper"

  def install
    ENV.append_path "PYTHONPATH", "#{Formula["libxml2"].opt_lib}/python2.7/site-packages"
    system "./autogen.sh" if build.head?
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/zenity", "--help"
  end
end
