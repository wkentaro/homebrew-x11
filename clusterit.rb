class Clusterit < Formula
  homepage "http://www.garbled.net/clusterit.html"
  url "https://downloads.sourceforge.net/project/clusterit/clusterit/clusterit-2.5/clusterit-2.5.tar.gz"
  sha256 "e50597fb361d9aefff0250108900a3837a4a14c46083d6eb5ed5d7fc42ce9f35"

  conflicts_with "couchdb-lucene", :because => "both install a `run` binary"
  conflicts_with "pdsh", :because => "both install `dshbak`"

  depends_on :x11

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
