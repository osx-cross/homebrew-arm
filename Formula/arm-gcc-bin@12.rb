# frozen_string_literal: true

class ArmGccBinAT12 < Formula
  @tar_file = if Hardware::CPU.arm?
    "arm-gnu-toolchain-12.2.rel1-darwin-arm64-arm-none-eabi.tar.xz"
  else
    "arm-gnu-toolchain-12.2.rel1-darwin-x86_64-arm-none-eabi.tar.xz"
  end

  @tar_file_sha = if Hardware::CPU.arm?
    "21a9e875250bcb0db8df4cb23dd43c94c00a1d3b98ecba9cdd6ed51586b12248"
  else
    "00c0eeb57ae92332f216151ac66df6ba17d2d3b306dac86f4006006f437b2902"
  end

  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads"

  url "https://developer.arm.com/-/media/Files/downloads/gnu/12.2.rel1/binrel/#{@tar_file}"
  version "12.2.Rel1"

  sha256 @tar_file_sha

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@12-12.2.Rel1"
    rebuild 2
    sha256 cellar: :any_skip_relocation, big_sur:  "f6bf8cdb4b4029c11c194b43ba76493ad1593993e1fac7e1dfb1c5d2f05943b9"
    sha256 cellar: :any_skip_relocation, catalina: "9318ba31774a22db2c8c283b91976ea40e712ef79b3d2a68abb1e80e04dfc2a1"
  end

  keg_only <<~EOS
    it may interfere with another version of arm-gcc-bin.
    This is useful if you want to have multiple versions installed
  EOS

  def install
    bin.install Dir["bin/*"]
    prefix.install Dir["arm-none-eabi", "include", "lib", "libexec", "share"]
  end

  test do
    assert_match "Arm GNU Toolchain #{version}", `#{opt_prefix}/bin/arm-none-eabi-gcc --version`
  end
end
