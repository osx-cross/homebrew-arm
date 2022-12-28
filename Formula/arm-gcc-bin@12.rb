class ArmGccBinAT12 < Formula
  @tar_file = if Hardware::CPU.arm?
    "arm-gnu-toolchain-12.2.rel1-darwin-arm64-arm-none-eabi.tar.xz"
  else
    "arm-gnu-toolchain-12.2.rel1-darwin-x86_64-arm-none-eabi.tar.xz"
  end

  @tar_file_sha = if Hardware::CPU.arm?
    "21a9e875250bcb0db8df4cb23dd43c94c00a1d3b98ecba9cdd6ed51586b12248"
  else
    "00c0eeb57ae92332f216151ac66df6ba17d2d3b306dac86f4006006f437b2902"
  end

  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads"

  url "https://developer.arm.com/-/media/Files/downloads/gnu/12.2.rel1/binrel/#{@tar_file}"
  version "12.2.Rel1"

  sha256 @tar_file_sha

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@12-12.2.Rel1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur:  "dbdef49e81a11359cda8110f4a8d992fb2e2383c694c237d3df637be1b298a48"
    sha256 cellar: :any_skip_relocation, catalina: "f2f063698c279a5dd8f40ad0f687de6d5f8984c1e47197572e4cde6568a8422c"
  end

  def install
    bin.install Dir["bin/*"]
    prefix.install Dir["arm-none-eabi", "include", "lib", "libexec", "share"]
  end

  test do
    system "true"
  end
end
