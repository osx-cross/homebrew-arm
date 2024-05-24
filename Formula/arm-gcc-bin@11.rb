# frozen_string_literal: true

class ArmGccBinAT11 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads"
  url "https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-darwin-x86_64-arm-none-eabi.tar.xz"
  version "11.3.Rel1"
  sha256 "826353d45e7fbaa9b87c514e7c758a82f349cb7fc3fd949423687671539b29cf"

  revision 1

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@11-11.3.Rel1_1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "56b998c4c26956678b9159f6d4f3e636ec9325395e7c12035b288ab8354d158e"
    sha256 cellar: :any_skip_relocation, ventura:      "42f4aa8b17d3294348b608fc71efb226f22f16a73eb5137a95531350bc4e43a1"
    sha256 cellar: :any_skip_relocation, monterey:     "b3e6cbc5004602aa3eea6401fdc72f77a7d80dbac67392a5fca2b61a2b84e54d"
  end

  keg_only <<~EOS
    it may interfere with another version of arm-gcc-bin.
    This is useful if you want to have multiple versions installed
  EOS

  def install
    bin.install Dir["bin/*"]
    prefix.install Dir["arm-none-eabi", "include", "lib", "libexec", "share"]
  end

  test do
    assert_match "Arm GNU Toolchain #{version}", `#{opt_prefix}/bin/arm-none-eabi-gcc --version`
  end
end
