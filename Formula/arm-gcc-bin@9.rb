class ArmGccBinAT9 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/open-source/gnu-toolchain/gnu-rm"
  url "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-mac.tar.bz2"
  version "9-2020-q2-update"
  sha256 "bbb9b87e442b426eca3148fa74705c66b49a63f148902a0ea46f676ec24f9ac6"

  revision 1

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@9-9-2020-q2-update_1"
    sha256 cellar: :any_skip_relocation, big_sur:  "8d013292bfbd13c7c7b6427c3d080f63db8980f360748af3163eac1e452dd8bd"
    sha256 cellar: :any_skip_relocation, catalina: "1911e7454e7de3dd380b69db5efd01bead63736da1807a0b3045c64a3b932b5a"
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
