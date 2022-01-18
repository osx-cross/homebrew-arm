class ArmGccBinSiliconAT10 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/open-source/gnu-toolchain/gnu-rm"
  url "https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/download/v10.3.1-2.3/xpack-arm-none-eabi-gcc-10.3.1-2.3-darwin-arm64.tar.gz"
  version "10.3-2.3"
  sha256 "a207301fb6c136f661a09024eb49424adf74cbc952a4cff150dfc7927206ab1a"
  depends_on arch: :arm64

  def install
    bin.install Dir["bin/*"]
    prefix.install Dir["arm-none-eabi", "lib", "share"]
  end
end
