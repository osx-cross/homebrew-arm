class ArmGccBinAT10 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/open-source/gnu-toolchain/gnu-rm"
  url "https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/10.3-2021.07/gcc-arm-none-eabi-10.3-2021.07-mac-10.14.6.tar.bz2"
  version "10.3-2021.07"
  sha256 "0a4554b248a1626496eeba56ad59d2bba4279cb485099f820bb887fe6a8b7ee4"

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
