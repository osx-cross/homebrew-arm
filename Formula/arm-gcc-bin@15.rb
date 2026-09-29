# frozen_string_literal: true

class ArmGccBinAT15 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://github.com/osx-cross/homebrew-arm"
  url "https://gitlab.arm.com/api/v4/projects/tooling%2Fgnu-toolchains-for-arm/packages/generic/gnu-toolchain/15.3.rel1/arm-gnu-toolchain-15.3.rel1-darwin-arm64-arm-none-eabi.tar.xz"
  sha256 "376808a59ca209c1413236f1c6a509e33da4b29857ab28642b9927cf3048af55"

  keg_only <<~KEG_ONLY_EOS
    it may interfere with another version of arm-gcc-bin.
    This is useful if you want to have multiple versions installed
  KEG_ONLY_EOS

  depends_on arch: :arm64

  def install
    bin.install (Dir["bin/*"] - ["bin/arm-none-eabi-gdb-py"])
    prefix.install Dir["arm-none-eabi", "include", "lib", "libexec", "share"]
  end

  def caveats
    <<~EOS
      arm-none-eabi-gdb-py links against python@3.9, which is end-of-life and will
      be removed from Homebrew in the future. It has been excluded from this
      formula to avoid a broken linkage. If you need up-to-date GDB Python
      scripting support, install a recompiled toolchain manually from:
        https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases
    EOS
  end

  test do
    assert_match "Arm GNU Toolchain #{version}".downcase, shell_output("#{opt_prefix}/bin/arm-none-eabi-gcc --version").downcase
  end
end
