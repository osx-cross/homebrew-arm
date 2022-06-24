class ArmNoneEabiBinutils < Formula
  desc "GNU Tools for ARM Embedded Processors - Binutils"
  homepage "https://www.gnu.org/software/binutils/binutils.html"

  url "https://ftp.gnu.org/gnu/binutils/binutils-2.38.tar.xz"
  mirror "https://ftpmirror.gnu.org/binutils/binutils-2.38.tar.xz"
  sha256 "e316477a914f567eccc34d5d29785b8b0f5a10208d36bbacedcc39048ecfe024"

  uses_from_macos "zlib"

  def install
    # https://sourceware.org/bugzilla/show_bug.cgi?id=23424
    ENV["CXXFLAGS"] = "-std=c++11 -Wno-c++11-narrowing"

    mkdir "build" do
      args = %W[
        --target=arm-none-eabi
        --prefix=#{prefix}
        --libdir=#{lib}/arm-none-eabi
        --infodir=#{info}
        --mandir=#{man}
        --enable-initfini-array
        --disable-nls
        --enable-plugins
        --enable-gold
        --enable-deterministic-archives
      ]

      system "../configure", *args
      system "make"
      system "make", "install"
    end

    info.rmtree # info files conflict with native binutils
  end

  def caveats
    <<~EOS
      For Mac computers with Apple silicon, arm-none-eabi-binutils might need Rosetta 2 to work properly.
      You can learn more about Rosetta 2 here:
          > https://support.apple.com/en-us/HT211861
    EOS
  end

  test do
    version_output = "GNU ld (GNU Binutils) 2.38\n"
    assert_equal `arm-none-eabi-ld -v`, version_output
  end
end
