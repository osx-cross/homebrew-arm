class ArmGccBinAT13 < Formula
  @tar_file = if Hardware::CPU.arm?
    "arm-gnu-toolchain-13.2.rel1-darwin-arm64-arm-none-eabi.tar.xz"
  else
    "arm-gnu-toolchain-13.2.rel1-darwin-x86_64-arm-none-eabi.tar.xz"
  end

  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads"
  url "https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/#{@tar_file}"
  sha256 @tar_file_sha

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@13-13.2.rel1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "91ec58e4f00cf911ed4d12534591b776e9b1217ceb3b5b5f582da76646f70de7"
    sha256 cellar: :any,                 ventura:      "6e8834c9c8bd67023b438451588ac679b2c520139ff9daec0692f184923078ec"
    sha256 cellar: :any,                 monterey:     "b2ea7549fb70b7a69438a814c84bd9ef637b33ee93ec135842e82b787aa1db34"
  end

  @tar_file_sha = if Hardware::CPU.arm?
    "39c44f8af42695b7b871df42e346c09fee670ea8dfc11f17083e296ea2b0d279"
  else
    "075faa4f3e8eb45e59144858202351a28706f54a6ec17eedd88c9fb9412372cc"
  end

  depends_on "xz" unless Hardware::CPU.arm?

  keg_only <<~KEG_ONLY_EOS
    it may interfere with another version of arm-gcc-bin.
    This is useful if you want to have multiple versions installed
  KEG_ONLY_EOS

  def install
    bin.install Dir["bin/*"]
    prefix.install Dir["arm-none-eabi", "include", "lib", "libexec", "share"]
  end

  test do
    assert_match "Arm GNU Toolchain #{version}", `#{opt_prefix}/bin/arm-none-eabi-gcc --version`
  end
end
