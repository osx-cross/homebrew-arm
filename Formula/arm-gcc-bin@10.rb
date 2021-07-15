class ArmGccBinAT10 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/open-source/gnu-toolchain/gnu-rm"
  url "https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-mac.tar.bz2"
  version "10-2020-q4-major"
  sha256 "bed12de3565d4eb02e7b58be945376eaca79a8ae3ebb785ec7344e7e2db0bdc0"

  revision 1

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@10-10-2020-q4-major_1"
    sha256 cellar: :any_skip_relocation, big_sur:  "cda2de1884bcb0855170ac855afc55c0d6cb29ae56fbfbbe8b5dc44da81da798"
    sha256 cellar: :any_skip_relocation, catalina: "e36e0775c3d14c05773e8214d4d9ab6be23245838f232a7fb472ab633e573bc6"
  end

  def install
    bin.install Dir["bin/*"]
    prefix.install Dir["arm-none-eabi", "lib", "share"]
  end
end
