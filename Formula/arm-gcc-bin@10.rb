# frozen_string_literal: true

class ArmGccBinAT10 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/open-source/gnu-toolchain/gnu-rm"
  url "https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-mac.tar.bz2"
  version "10.3-2021.10"
  sha256 "fb613dacb25149f140f73fe9ff6c380bb43328e6bf813473986e9127e2bc283b"

  revision 1

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@10-10.3-2021.10_1"
    sha256 cellar: :any_skip_relocation, big_sur:  "3161968bd3254480a4bd7db628459556d14878f0dd2720062cc6832dc2c4c439"
    sha256 cellar: :any_skip_relocation, catalina: "3f8e167829bd91b011a565ebb938f774d2cf4ae359e9c70bc69589f76d50deb1"
  end

  def install
    bin.install Dir["bin/*"]
    prefix.install Dir["arm-none-eabi", "lib", "share"]
  end
end
