# frozen_string_literal: true

class ArmGccBinAT9 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/open-source/gnu-toolchain/gnu-rm"
  url "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-mac.tar.bz2"
  version "9-2020-q2-update"
  sha256 "bbb9b87e442b426eca3148fa74705c66b49a63f148902a0ea46f676ec24f9ac6"

  revision 2

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@9-9-2020-q2-update_2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur:  "869fdc3d1289e879b16f91fb7c1f209b33c502eb8fa90c69b2ddd509c5ff3c4d"
    sha256 cellar: :any_skip_relocation, catalina: "8dab115e5ee7be5cb5a223ccddad7485d667afb6d0ffc6bfd74f7ce902022094"
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
    assert_match "GNU Arm Embedded Toolchain #{version}", `#{opt_prefix}/bin/arm-none-eabi-gcc --version`
  end
end
