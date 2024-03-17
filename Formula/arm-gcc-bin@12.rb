class ArmGccBinAT12 < Formula
  @tar_file = if Hardware::CPU.arm?
    "arm-gnu-toolchain-12.2.MPACBTI-Rel1-darwin-arm64-arm-none-eabi.tar.xz"
  else
    "arm-gnu-toolchain-12.2.MPACBTI-Rel1-darwin-x86_64-arm-none-eabi.tar.xz"
  end

  @tar_file_sha = if Hardware::CPU.arm?
    "0569c8379e3335a8de104ef0d19f0b79c8644c571a9aa005049f0300664a68a1"
  else
    "febcb19108a400576a7cfa312b46c2393b78ab41cfcc450d219e9485b0d8e375"
  end

  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads"

  url "https://developer.arm.com/-/media/Files/downloads/gnu/12.2.mpacbti-rel1/binrel/#{@tar_file}"
  version "12.2.MPACBTI-Rel1"

  sha256 @tar_file_sha

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
