class Gtkwave < Formula
  desc "A fully featured GTK+ based wave viewer"
  homepage "http://gtkwave.sourceforge.net/"
  url "http://gtkwave.sourceforge.net/gtkwave-3.3.65.tar.gz"
  sha256 "64eb091e70c83bf03df14e01d338151e888fb4099c4695c2e6e40ce27d249bd5"
  revision 1

  bottle do
    root_url "https://homebrew.bintray.com/bottles-x11"
    cellar :any
    sha256 "290a1022afc3578c32d924447698c5238c4e30538336eeacc2b096236f9efde7" => :yosemite
    sha256 "5cf8d5a2405987be2cd7c6e01284aba5befe7616decaf007732636bb8e30291e" => :mavericks
    sha256 "5971a74f75e0c2f9ac99863391d11744b56253a16ca80fd52ff821eeb7af4c4f" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "gtk+"
  depends_on "gtk-mac-integration"
  depends_on "xz" # For LZMA support

  # patches to get gtk-mac-integration working properly
  # email sent to author with diff, filing bugs on the sourceforge page has been disabled
  patch :DATA

  def install
    args = ["--disable-dependency-tracking",
            "--disable-silent-rules",
            "--prefix=#{prefix}"
           ]

    unless MacOS::CLT.installed?
      args << "--with-tcl=#{MacOS.sdk_path}/System/Library/Frameworks/Tcl.framework"
      args << "--with-tk=#{MacOS.sdk_path}/System/Library/Frameworks/Tk.framework"
    end

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/gtkwave", "--version"
  end
end
__END__
diff --git a/src/main.c b/src/main.c
index 8eaf97a..3b594a2 100644
--- a/src/main.c
+++ b/src/main.c
@@ -1778,15 +1778,15 @@ if(GLOBALS->use_toolbutton_interface)

 #ifdef MAC_INTEGRATION
 {
-GtkOSXApplication *theApp = g_object_new(GTK_TYPE_OSX_APPLICATION, NULL);
+GtkosxApplication *theApp = g_object_new(GTKOSX_TYPE_APPLICATION, NULL);
 gtk_widget_hide(menubar);
-gtk_osxapplication_set_menu_bar(theApp, GTK_MENU_SHELL(menubar));
-gtk_osxapplication_set_use_quartz_accelerators(theApp, TRUE);
-gtk_osxapplication_ready(theApp);
-gtk_osxapplication_set_dock_icon_pixbuf(theApp, dock_pb);
+gtkosx_application_set_menu_bar(theApp, GTK_MENU_SHELL(menubar));
+gtkosx_application_set_use_quartz_accelerators(theApp, TRUE);
+gtkosx_application_ready(theApp);
+gtkosx_application_set_dock_icon_pixbuf(theApp, dock_pb);
 if(GLOBALS->loaded_file_type == MISSING_FILE)
	{
-	gtk_osxapplication_attention_request(theApp, INFO_REQUEST);
+	gtkosx_application_attention_request(theApp, INFO_REQUEST);
	}

 g_signal_connect(theApp, "NSApplicationOpenFile", G_CALLBACK(deal_with_finder_open), NULL);
@@ -2023,15 +2023,15 @@ g_signal_connect(theApp, "NSApplicationBlockTermination", G_CALLBACK(deal_with_t

 #ifdef MAC_INTEGRATION
 {
-GtkOSXApplication *theApp = g_object_new(GTK_TYPE_OSX_APPLICATION, NULL);
+GtkosxApplication *theApp = g_object_new(GTKOSX_TYPE_APPLICATION, NULL);
 gtk_widget_hide(menubar);
-gtk_osxapplication_set_menu_bar(theApp, GTK_MENU_SHELL(menubar));
-gtk_osxapplication_set_use_quartz_accelerators(theApp, TRUE);
-gtk_osxapplication_ready(theApp);
-gtk_osxapplication_set_dock_icon_pixbuf(theApp, dock_pb);
+gtkosx_application_set_menu_bar(theApp, GTK_MENU_SHELL(menubar));
+gtkosx_application_set_use_quartz_accelerators(theApp, TRUE);
+gtkosx_application_ready(theApp);
+gtkosx_application_set_dock_icon_pixbuf(theApp, dock_pb);
 if(GLOBALS->loaded_file_type == MISSING_FILE)
	{
-	gtk_osxapplication_attention_request(theApp, INFO_REQUEST);
+	gtkosx_application_attention_request(theApp, INFO_REQUEST);
	}

 g_signal_connect(theApp, "NSApplicationOpenFile", G_CALLBACK(deal_with_finder_open), NULL);
@@ -2904,7 +2904,7 @@ if(GLOBALS->stems_type != WAVE_ANNO_NONE)
					{
					char buf[64];
 #ifdef MAC_INTEGRATION
-					const gchar *p = quartz_application_get_executable_path();
+					const gchar *p = gtkosx_application_get_executable_path();
 #endif
					sprintf(buf, "%08x", shmid);

@@ -3009,7 +3009,7 @@ void optimize_vcd_file(void) {
       }
       else {
 #ifdef MAC_INTEGRATION
-	const gchar *p = quartz_application_get_executable_path();
+	const gchar *p = gtkosx_application_get_executable_path();
	if(p && strstr(p, "Contents/"))
		{
		const char *xec = "../Resources/bin/vcd2fst";
diff --git a/src/menu.c b/src/menu.c
index abd3baa..5d9fa7d 100644
--- a/src/menu.c
+++ b/src/menu.c
@@ -2250,10 +2250,10 @@ if(GLOBALS->helpbox_is_active)
         }
	else
	{
-        const gchar *bundle_id = quartz_application_get_bundle_id();
+        const gchar *bundle_id = gtkosx_application_get_bundle_id();
         if(bundle_id)
                 {
-                const gchar *rpath = quartz_application_get_resource_path();
+                const gchar *rpath = gtkosx_application_get_resource_path();
                 const char *suf = "/doc/gtkwave.pdf";
		char *pdfpath = NULL;
		FILE *handle;
@@ -8671,7 +8671,9 @@ if(GLOBALS->loaded_file_type != LXT_FILE)
 gtk_window_add_accel_group(GTK_WINDOW(window), global_accel);

 #ifdef MAC_INTEGRATION
+#if defined(HAVE_LIBTCL)
 gtk_widget_hide(menu_wlist[WV_MENU_TCLSEP]);
+#endif
 gtk_widget_hide(menu_wlist[WV_MENU_FQY]);
 #endif

diff --git a/src/rc.c b/src/rc.c
index cdda463..d31eb0e 100644
--- a/src/rc.c
+++ b/src/rc.c
@@ -1003,10 +1003,10 @@ if(!(handle=fopen(rcname,"rb")))
	if(!(handle=fopen(rcpath,"rb")))
		{
 #ifdef MAC_INTEGRATION
-		const gchar *bundle_id = quartz_application_get_bundle_id();
+		const gchar *bundle_id = gtkosx_application_get_bundle_id();
		if(bundle_id)
			{
-			const gchar *rpath = quartz_application_get_resource_path();
+			const gchar *rpath = gtkosx_application_get_resource_path();
			const char *suf = "/gtkwaverc";

			rcpath = NULL;
diff --git a/src/savefile.c b/src/savefile.c
index a6fed4f..aeca8c4 100644
--- a/src/savefile.c
+++ b/src/savefile.c
@@ -2716,7 +2716,7 @@ return(deal_with_rpc_open_2(path, user_data, FALSE));
 /*
  * block termination if in the middle of something important
  */
-gboolean deal_with_termination(GtkOSXApplication *app, gpointer user_data)
+gboolean deal_with_termination(GtkosxApplication *app, gpointer user_data)
 {
 (void)app;
 (void)user_data;
@@ -2736,7 +2736,7 @@ return(do_not_terminate);
  * Integration with Finder...
  * cache name and load in later off a timer (similar to caching DnD for quartz...)
  */
-gboolean deal_with_finder_open(GtkOSXApplication *app, gchar *path, gpointer user_data)
+gboolean deal_with_finder_open(GtkosxApplication *app, gchar *path, gpointer user_data)
 {
 (void)app;

diff --git a/src/savefile.h b/src/savefile.h
index 4ced9f8..adc272d 100644
--- a/src/savefile.h
+++ b/src/savefile.h
@@ -28,8 +28,8 @@ int parsewavline_lx2(char *w, char *alias, int depth);
 char *find_dumpfile(char *orig_save, char *orig_dump, char *this_save);

 #ifdef MAC_INTEGRATION
-gboolean deal_with_finder_open(GtkOSXApplication *app, gchar *path, gpointer user_data);
-gboolean deal_with_termination(GtkOSXApplication *app, gpointer user_data);
+gboolean deal_with_finder_open(GtkosxApplication *app, gchar *path, gpointer user_data);
+gboolean deal_with_termination(GtkosxApplication *app, gpointer user_data);
 #endif

 gboolean deal_with_rpc_open(const gchar *path, gpointer user_data);
