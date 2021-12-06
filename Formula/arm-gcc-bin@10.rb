class ArmGccBinAT10 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/open-source/gnu-toolchain/gnu-rm"
  url "https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-mac.tar.bz2"
  version "10.3-2021.10"
  sha256 "fb613dacb25149f140f73fe9ff6c380bb43328e6bf813473986e9127e2bc283b"

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@10-10.3-2021.10"
    sha256 cellar: :any_skip_relocation, big_sur: "bf9b941c1436e2d9ce39b8f30e55253f5d1284f5b8b1506012c3c3aa9e132d1f"
  end

  def install
    bin.install Dir["bin/*"]
    prefix.install Dir["arm-none-eabi", "lib", "share"]
  end
end
