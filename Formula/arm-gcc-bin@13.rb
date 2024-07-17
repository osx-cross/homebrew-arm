# frozen_string_literal: true

class ArmGccBinAT13 < Formula
  @tar_file = if Hardware::CPU.arm?
    "arm-gnu-toolchain-13.3.rel1-darwin-arm64-arm-none-eabi.tar.xz"
  else
    "arm-gnu-toolchain-13.3.rel1-darwin-x86_64-arm-none-eabi.tar.xz"
  end

  @tar_file_sha = if Hardware::CPU.arm?
    "fb6921db95d345dc7e5e487dd43b745e3a5b4d5c0c7ca4f707347148760317b4"
  else
    "1ab00742d1ed0926e6f227df39d767f8efab46f5250505c29cb81f548222d794"
  end

  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads"
  url "https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/#{@tar_file}"
  sha256 @tar_file_sha

  depends_on "xz" unless Hardware::CPU.arm?
  depends_on "zstd" unless Hardware::CPU.arm?

  keg_only <<~KEG_ONLY_EOS
    it may interfere with another version of arm-gcc-bin.
    This is useful if you want to have multiple versions installed
  KEG_ONLY_EOS

  def install
    bin.install Dir["bin/*"]
    prefix.install Dir["arm-none-eabi", "include", "lib", "libexec", "share"]
  end

  test do
    assert_match "Arm GNU Toolchain #{version}".strip.downcase, `#{opt_prefix}/bin/arm-none-eabi-gcc --version`.strip.downcase
  end
end
