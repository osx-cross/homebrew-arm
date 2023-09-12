class ArmNoneEabiBinutils < Formula
  desc "GNU Tools for ARM Embedded Processors - Binutils"
  homepage "https://www.gnu.org/software/binutils/binutils.html"

  url "https://ftp.gnu.org/gnu/binutils/binutils-2.38.tar.xz"
  mirror "https://ftpmirror.gnu.org/binutils/binutils-2.38.tar.xz"
  sha256 "e316477a914f567eccc34d5d29785b8b0f5a10208d36bbacedcc39048ecfe024"

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-none-eabi-binutils-2.38"
    rebuild 3
    sha256 ventura:  "4e076d6c8ac889a0a22dab0a34464fc9dc4718222066352b0dda68cb7465a621"
    sha256 monterey: "80ca3274d451abe30bf14c2fdff3b622ce8b50233f9b2d14a345c2da3fe0ceed"
    sha256 big_sur:  "7f192d490434f1b8bf092df76055022641f3f11ebf1f9650d0726cc29f6c32d6"
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
