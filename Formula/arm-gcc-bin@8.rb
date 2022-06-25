class ArmGccBinAT8 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/open-source/gnu-toolchain/gnu-rm"
  url "https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2019q3/RC1.1/gcc-arm-none-eabi-8-2019-q3-update-mac.tar.bz2"
  version "8-2019-q3-update"
  sha256 "fc235ce853bf3bceba46eff4b95764c5935ca07fc4998762ef5e5b7d05f37085"

  revision 2

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@8-8-2019-q3-update_1"
    sha256 cellar: :any_skip_relocation, big_sur:  "0c98c1f917ec17851b1d214ba64075bc97f9dc3d292c24a66a5f967c8fb9de6c"
    sha256 cellar: :any_skip_relocation, catalina: "23c402ed8df2d743ca650fdb6e72d066d3afe3c6f8f363207fa19cb49cb77d65"
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
