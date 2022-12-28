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
    sha256 cellar: :any_skip_relocation, big_sur:  "7163811bf21aa6a06f4f57aeac31c07a2c604c85ba20d962086b85c42ae9502d"
    sha256 cellar: :any_skip_relocation, catalina: "bc98e405bd431134f8becab57cedc80792650f4e0462cacff4e06fa612b2bd03"
  end

  def install
    bin.install Dir["bin/*"]
    prefix.install Dir["arm-none-eabi", "include", "lib", "libexec", "share"]
  end

  test do
    system "true"
  end
end
