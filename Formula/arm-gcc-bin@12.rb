# frozen_string_literal: true

class ArmGccBinAT12 < Formula
  @tar_file = if Hardware::CPU.arm?
    "arm-gnu-toolchain-12.3.rel1-darwin-arm64-arm-none-eabi.tar.xz"
  else
    "arm-gnu-toolchain-12.3.rel1-darwin-x86_64-arm-none-eabi.tar.xz"
  end

  @tar_file_sha = if Hardware::CPU.arm?
    "fe2317cfcb61f05d82883002f255545edced5f187b420a3222cf4febbdb04839"
  else
    "5a86ca86f8c73aea47c878b4623f3d5cfa13b436f3b60c6a3fd89a6c1285cc03"
  end

  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://github.com/osx-cross/homebrew-arm"

  url "https://gitlab.arm.com/api/v4/projects/tooling%2Fgnu-toolchains-for-arm/packages/generic/gnu-toolchain/12.3.rel1/#{@tar_file}"
  version "12.3.Rel1"

  sha256 @tar_file_sha

  keg_only <<~EOS
    it may interfere with another version of arm-gcc-bin.
    This is useful if you want to have multiple versions installed
  EOS

  def install
    bin.install Dir["bin/*"]
    prefix.install Dir["arm-none-eabi", "include", "lib", "libexec", "share"]
  end

  test do
    assert_match "Arm GNU Toolchain #{version}".downcase,
                 shell_output("#{opt_prefix}/bin/arm-none-eabi-gcc --version").downcase
  end
end
