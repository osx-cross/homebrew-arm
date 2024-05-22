class ArmGccBinAT13 < Formula
  @tar_file = if Hardware::CPU.arm?
    "arm-gnu-toolchain-13.2.rel1-darwin-arm64-arm-none-eabi.tar.xz"
  else
    "arm-gnu-toolchain-13.2.rel1-darwin-x86_64-arm-none-eabi.tar.xz"
  end

  @tar_file_sha = if Hardware::CPU.arm?
    "21a9e875250bcb0db8df4cb23dd43c94c00a1d3b98ecba9cdd6ed51586b12248"
  else
    "075faa4f3e8eb45e59144858202351a28706f54a6ec17eedd88c9fb9412372cc"
  end

  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads"

  url "https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/#{@tar_file}"
  version "13.2.Rel1"

  sha256 @tar_file_sha

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
