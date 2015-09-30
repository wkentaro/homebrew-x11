class Zenity < Formula
  desc "GTK+ dialog boxes for the command-line"
  homepage "https://live.gnome.org/Zenity"
  url "https://download.gnome.org/sources/zenity/3.18/zenity-3.18.0.tar.xz"
  sha256 "0efafea95a830f3bf6eca805ff4a8008df760a6ad3e81181b9473dcf721c3a69"

  bottle do
    sha256 "afc146f738d95f38388a1a92eaefe9131d9b3f037d99022f7c16f69e8da440ea" => :el_capitan
    sha256 "d9642ae03421e0b1789ca30e5d34286d5a2a249b03841b7962f03414e91551f2" => :yosemite
    sha256 "d1d5f11af4639e7b99e0f571695edbc66b2006876d018a740ccbebcd0808b97d" => :mavericks
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
