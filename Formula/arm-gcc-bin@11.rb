class ArmGccBinAT11 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads"
  url "https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-darwin-x86_64-arm-none-eabi.tar.xz"
  version "11.3.Rel1"
  sha256 "826353d45e7fbaa9b87c514e7c758a82f349cb7fc3fd949423687671539b29cf"

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@11-11.3.Rel1"
    sha256 cellar: :any_skip_relocation, big_sur:  "8d40a8dfd259c43b45f7a7bc8c6b8e7105c5395ee05b41dfd3228628e6d2e15d"
    sha256 cellar: :any_skip_relocation, catalina: "1479060c84d3c0581bdbf0aef78834f77d7d5b4dd7678366c1e3a883dd4ddbd6"
  end

  def install
    bin.install Dir["bin/*"]
    prefix.install Dir["arm-none-eabi", "include", "lib", "libexec", "share"]
  end

  test do
    system "true"
  end
end
