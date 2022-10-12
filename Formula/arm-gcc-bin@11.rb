class ArmGccBinAT11 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads"
  url "https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-darwin-x86_64-arm-none-eabi.tar.xz"
  version "11.3.Rel1"
  sha256 "826353d45e7fbaa9b87c514e7c758a82f349cb7fc3fd949423687671539b29cf"

  def install
    bin.install Dir["bin/*"]
    prefix.install Dir["arm-none-eabi", "include", "lib", "libexec", "share"]
  end

  test do
    version_output = "gcc version 11.3.1 20220712 (Arm GNU Toolchain 11.3.Rel1)"
    assert_match version_output, `arm-none-eabi-gcc -v`
  end
end
