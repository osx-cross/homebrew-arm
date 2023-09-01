class ArmNoneEabiBinutils < Formula
  desc "GNU Tools for ARM Embedded Processors - Binutils"
  homepage "https://www.gnu.org/software/binutils/binutils.html"

  url "https://ftp.gnu.org/gnu/binutils/binutils-2.38.tar.xz"
  mirror "https://ftpmirror.gnu.org/binutils/binutils-2.38.tar.xz"
  sha256 "e316477a914f567eccc34d5d29785b8b0f5a10208d36bbacedcc39048ecfe024"

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-none-eabi-binutils-2.38"
    rebuild 2
    sha256 ventura:  "e1c6b60fb96da269fa5f38bf761be8775b6745c13517698efc7a2ffc4fdef6da"
    sha256 monterey: "48ed296b3802e67845e7f11b71f0f67d6f97ac7c52ea5b4010ed20fea75bd9d3"
    sha256 big_sur:  "334c4298ac9c3ece49f5cddaf6ab4d7913c4dab5dd35c1e9d4dc849c39ac79db"
  end

  keg_only "it might interfere with other version of arm-gcc.\n" \
           "This is useful if you want to have multiple version of arm-none-eabi-gcc\n" \
           "installed on the same machine"

  uses_from_macos "zlib"

  on_ventura :or_newer do
    depends_on "texinfo" => :build
  end

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
    assert_match "GNU ld (GNU Binutils) 2.38\n", `#{opt_prefix}/bin/arm-none-eabi-ld -v`
  end
end
