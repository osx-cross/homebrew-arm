# frozen_string_literal: true

class ArmGccBinAT15 < Formula
  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://github.com/osx-cross/homebrew-arm"
  url "https://developer.arm.com/-/media/Files/downloads/gnu/15.2.rel1/binrel/arm-gnu-toolchain-15.2.rel1-darwin-arm64-arm-none-eabi.tar.xz"
  sha256 "1938a84b7105c192e3fb4fa5e893ba25f425f7ddab40515ae608cd40f68669a8"

  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@15-15.2.rel1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3ad29ace172c668a25900cec50e0e1f762fecfdbea9dd394c9f1de41f57cccac"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "879cd211418a95969420c6a1800c23830c3e57e99cde1663e480f5ab46310310"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f9473b45b70109b12c0976b5248d69c60365816c2813fd73006308a4f63e18fb"
  end

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
