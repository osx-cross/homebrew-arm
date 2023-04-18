class ArmGccBinAT8 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/open-source/gnu-toolchain/gnu-rm"
  url "https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2019q3/RC1.1/gcc-arm-none-eabi-8-2019-q3-update-mac.tar.bz2"
  version "8-2019-q3-update"
  sha256 "fc235ce853bf3bceba46eff4b95764c5935ca07fc4998762ef5e5b7d05f37085"

  revision 2

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@8-8-2019-q3-update_2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur:  "93e0d82f902bc5381dc8f60a10dba0da349f455e5ca8ba3bccabc62b3a895966"
    sha256 cellar: :any_skip_relocation, catalina: "e07ea89789abf40562ed094ee7ee6c100bbc94d80439f051b477002b2b85b508"
  end

  keg_only <<~EOS
    it may interfere with another version of arm-gcc-bin.
    This is useful if you want to have multiple versions installed
  EOS

  def install
    bin.install Dir["bin/*"]
    prefix.install Dir["arm-none-eabi", "lib", "share"]
  end

  test do
    assert_match "GNU Tools for Arm Embedded Processors #{version}", `#{opt_prefix}/bin/arm-none-eabi-gcc --version`
  end
end
