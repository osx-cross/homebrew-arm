class ArmGccBinAT10 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/open-source/gnu-toolchain/gnu-rm"
  url "https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/10.3-2021.07/gcc-arm-none-eabi-10.3-2021.07-mac-10.14.6.tar.bz2"
  version "10.3-2021.07"
  sha256 "0a4554b248a1626496eeba56ad59d2bba4279cb485099f820bb887fe6a8b7ee4"
  revision 1

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@10-10.3-2021.07_1"
    sha256 cellar: :any_skip_relocation, big_sur:  "f689a41a3ecaa774e94520b75c6e99212791009ff1926c73c2ac665d460f9b82"
    sha256 cellar: :any_skip_relocation, catalina: "df57a0cb8c87465ebbb32fe1ce4c249899d46c38a717be2e35dd6ffcd96ebb80"
  end

  def install
    bin.install Dir["bin/*"]
    prefix.install Dir["arm-none-eabi", "lib", "share"]
  end
end
