# frozen_string_literal: true

class ArmGccBinAT8 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/open-source/gnu-toolchain/gnu-rm"
  url "https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2019q3/RC1.1/gcc-arm-none-eabi-8-2019-q3-update-mac.tar.bz2"
  version "8-2019-q3-update"
  sha256 "fc235ce853bf3bceba46eff4b95764c5935ca07fc4998762ef5e5b7d05f37085"

  revision 3

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@8-8-2019-q3-update_3"
    sha256 cellar: :any_skip_relocation, ventura:  "fabccd76e4fe436f01f42673f1a2733b38df424e1cdfd77da076d9deb171e649"
    sha256 cellar: :any_skip_relocation, monterey: "163081c2b3f24a1447d9247549e27469989f7befac151bdd2957bafcfd2458f6"
    sha256 cellar: :any_skip_relocation, big_sur:  "d1d10c396f5f7d324c29336ae2cd57d815b90574d7dc2560115d4b914ebcc622"
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
