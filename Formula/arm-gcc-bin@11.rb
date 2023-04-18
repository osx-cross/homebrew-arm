class ArmGccBinAT11 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads"
  url "https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-darwin-x86_64-arm-none-eabi.tar.xz"
  version "11.3.Rel1"
  sha256 "826353d45e7fbaa9b87c514e7c758a82f349cb7fc3fd949423687671539b29cf"

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@11-11.3.Rel1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur:  "49ed3e200709cc90d43850d651b167529265002854ad522960e36b041a51400f"
    sha256 cellar: :any_skip_relocation, catalina: "6ff4b710cdc595aac9ea0af7dcb3c86b16424a45de0fe789def3603f5f34f9df"
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
