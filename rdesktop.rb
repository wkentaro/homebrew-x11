class Rdesktop < Formula
  homepage "http://www.rdesktop.org/"
  url "https://downloads.sourceforge.net/project/rdesktop/rdesktop/1.8.3/rdesktop-1.8.3.tar.gz"
  mirror "https://mirrors.kernel.org/debian/pool/main/r/rdesktop/rdesktop_1.8.3.orig.tar.gz"
  sha256 "88b20156b34eff5f1b453f7c724e0a3ff9370a599e69c01dc2bf0b5e650eece4"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    sha256 "a6fe9d0323bbdc6db424f056b1cf20df23c35a1d4f15ab52c1b0eb30e19287e7" => :yosemite
    sha256 "fdfac37d70b9e750de33be617345d0d7226bcc764e8a3fbd16cc2ef8e0fc8731" => :mavericks
    sha256 "162ad10246d51275699969b449aa09e30aaa852c7892331970bccc587f5a2163" => :mountain_lion
  end

  depends_on "openssl"
  depends_on :x11

  # Note: The patch below is meant to remove the reference to the
  # undefined symbol SCARD_CTL_CODE. Since we are compiling with
  # --disable-smartcard, we don't need it anyway (and it should
  # probably have been #ifdefed in the original code).
  # upstream bug report: https://sourceforge.net/p/rdesktop/bugs/352/
  patch :DATA

  def install
    args = ["--prefix=#{prefix}",
            "--disable-credssp",
            "--disable-smartcard", # disable temporally before upstream fix
            "--with-openssl=#{Formula["openssl"].opt_prefix}",
            "--x-includes=#{MacOS::X11.include}",
            "--x-libraries=#{MacOS::X11.lib}"]
    system "./configure", *args
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rdesktop -help 2>&1", 64)
  end
end

__END__
diff --git a/scard.c b/scard.c
index caa0745..5521ee9 100644
--- a/scard.c
+++ b/scard.c
@@ -2152,7 +2152,6 @@ TS_SCardControl(STREAM in, STREAM out)
	{
		/* Translate to local encoding */
		dwControlCode = (dwControlCode & 0x3ffc) >> 2;
-		dwControlCode = SCARD_CTL_CODE(dwControlCode);
	}
	else
	{
@@ -2198,7 +2197,7 @@ TS_SCardControl(STREAM in, STREAM out)
	}

 #ifdef PCSCLITE_VERSION_NUMBER
-	if (dwControlCode == SCARD_CTL_CODE(3400))
+	if (0)
	{
		int i;
		SERVER_DWORD cc;
