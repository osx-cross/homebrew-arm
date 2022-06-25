class ArmGccBinAT9 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/open-source/gnu-toolchain/gnu-rm"
  url "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-mac.tar.bz2"
  version "9-2020-q2-update"
  sha256 "bbb9b87e442b426eca3148fa74705c66b49a63f148902a0ea46f676ec24f9ac6"

  revision 2

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@9-9-2020-q2-update_2"
    sha256 cellar: :any_skip_relocation, big_sur:  "97d2f5245a788b4202638d53a4d460e76fdac5e88c4dae312362f6b4aa6d30be"
    sha256 cellar: :any_skip_relocation, catalina: "35beb74a2e15558ed0ff0ecc08223784dd0585087ebf06950247f0b4521630af"
  end

  keg_only <<~EOS
    it may interfere with another version of arm-gcc-bin.
    This is useful if you want to have multiple versions installed
  EOS

  def install
    bin.install Dir["bin/*"]
    prefix.install Dir["arm-none-eabi", "lib", "share"]
  end
end
