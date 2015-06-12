class Eiffelstudio < Formula
  desc "A development environment for the Eiffel language"
  homepage "https://www.eiffel.com"
  url "https://ftp.eiffel.com/pub/download/15.01/eiffelstudio-15.01.tar"
  sha256 "3d2984bac35326e3860ee88dd7bba877b7a47e3d07b3cd6946b51a152577642c"

  depends_on "pkg-config" => :build
  depends_on "gtk+"

  def ise_platform
    if Hardware::CPU.ppc?
      "macosx-ppc"
    elsif MacOS.prefer_64_bit?
      "macosx-x86-64"
    else
      "macosx-x86"
    end
  end

  def install
    system "./compile_exes", ise_platform
    system "./make_images", ise_platform
    prefix.install Dir["Eiffel_15.01/*"]
    bin.mkpath
    env = { :ISE_EIFFEL => prefix, :ISE_PLATFORM => ise_platform }
    (bin + "ec").write_env_script(prefix+"studio/spec/#{ise_platform}/bin/ec", env)
    (bin + "ecb").write_env_script(prefix+"studio/spec/#{ise_platform}/bin/ecb", env)
    (bin + "estudio").write_env_script(prefix+"studio/spec/#{ise_platform}/bin/estudio", env)
    (bin + "finish_freezing").write_env_script(prefix+"studio/spec/#{ise_platform}/bin/finish_freezing", env)
    (bin + "compile_all").write_env_script(prefix+"tools/spec/#{ise_platform}/bin/compile_all", env)
    (bin + "iron").write_env_script(prefix+"tools/spec/#{ise_platform}/bin/iron", env)
    (bin + "syntax_updater").write_env_script(prefix+"tools/spec/#{ise_platform}/bin/syntax_updater", env)
    (bin + "vision2_demo").write_env_script(prefix+"vision2_demo/spec/#{ise_platform}/bin/vision2_demo", env)
  end

  test do
    # More extensive testing requires the full test suite
    # which is not part of this package.
    system "#{prefix}/studio/spec/#{ise_platform}/bin/ec", "-version"
  end
end
