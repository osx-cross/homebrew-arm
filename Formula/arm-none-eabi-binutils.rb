# frozen_string_literal: true

class ArmNoneEabiBinutils < Formula
  desc "GNU Tools for ARM Embedded Processors - Binutils"
  homepage "https://www.gnu.org/software/binutils/binutils.html"

  url "https://ftp.gnu.org/gnu/binutils/binutils-2.41.tar.xz"
  mirror "https://ftpmirror.gnu.org/binutils/binutils-2.41.tar.xz"
  sha256 "ae9a5789e23459e59606e6714723f2d3ffc31c03174191ef0d015bdf06007450"

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-none-eabi-binutils-2.41"
    sha256 arm64_sonoma: "228bc6d6d41fd0f99abd9bf5918733b6ff260abaa8ae97ef4119e6a4b7222e87"
    sha256 ventura:      "60bd5ba8a2d0e5e9d5843e89ad77debc23a9dc90c29be0b55f03bddde4b54098"
    sha256 monterey:     "4f5ea04ee0667d648c0595a74da2f91ec2c87d2d13cc930b05f93c1ac7dce368"
  end

  keg_only "it might interfere with other version of arm-gcc.\n" \
           "This is useful if you want to have multiple version of arm-none-eabi-gcc\n" \
           "installed on the same machine"

  depends_on "pkg-config" => :build
  depends_on "texinfo" => :build

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

  test do
    assert_match "GNU ld (GNU Binutils) 2.41\n", `#{opt_prefix}/bin/arm-none-eabi-ld -v`
  end
end
