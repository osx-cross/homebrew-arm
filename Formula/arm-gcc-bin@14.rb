# frozen_string_literal: true

class ArmGccBinAT14 < Formula
  @tar_file = if Hardware::CPU.arm?
    "arm-gnu-toolchain-14.2.rel1-darwin-arm64-arm-none-eabi.tar.xz"
  else
    "arm-gnu-toolchain-14.2.rel1-darwin-x86_64-arm-none-eabi.tar.xz"
  end

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@14-14.2.rel1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b46c5d8026c8b1d1c410721da8259a4e1fca09aba222f644bec9eee8a5c7a850"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "908b92f97471ead3ac65f8997df61ccd22c7cf298d283e9d56e0dc10207851e0"
    sha256 cellar: :any,                 ventura:       "5d1aa55a69ab3e028ea4d29372190365f946f176c1efdf5da1ec8034694a6f3c"
  end

  @tar_file_sha = if Hardware::CPU.arm?
    "c7c78ffab9bebfce91d99d3c24da6bf4b81c01e16cf551eb2ff9f25b9e0a3818"
  else
    "2d9e717dd4f7751d18936ae1365d25916534105ebcb7583039eff1092b824505"
  end

  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads"
  url "https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/#{@tar_file}"
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
    assert_match "Arm GNU Toolchain #{version}".downcase, shell_output("#{opt_prefix}/bin/arm-none-eabi-gcc --version").downcase
  end
end
