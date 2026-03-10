# frozen_string_literal: true

class ArmGccBinAT14 < Formula
  @tar_file = if Hardware::CPU.arm?
    "14.3.rel1/binrel/arm-gnu-toolchain-14.3.rel1-darwin-arm64-arm-none-eabi.tar.xz"
  else
    "14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-darwin-x86_64-arm-none-eabi.tar.xz"
  end

  desc "Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors"
  homepage "https://github.com/osx-cross/homebrew-arm"
  url "https://developer.arm.com/-/media/Files/downloads/gnu/#{@tar_file}"
  sha256 @tar_file_sha
  bottle do
    root_url "https://github.com/osx-cross/homebrew-arm/releases/download/arm-gcc-bin@14-14.3.rel1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "302083710aa69ac68c9100d44d08b511b0d35f4262bef843f549ddf7697ade52"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d57c17e36fbb486b64fdc626173009935c23bb92710a8aa5b8854892e5332158"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "99e037d7b224c32bf27653c616e23b28adf2c974b08484dc2cb45d599893540a"
  end

  @tar_file_sha = if Hardware::CPU.arm?
    "30f4d08b219190a37cded6aa796f4549504902c53cfc3c7e044a8490b6eba1f7"
  else
    "2d9e717dd4f7751d18936ae1365d25916534105ebcb7583039eff1092b824505"
  end
  # x86_64: 14.3 is not available upstream; override the version scanned from the
  # URL so the bottle system sees a single consistent version across architectures.
  version "14.3.rel1" unless Hardware::CPU.arm?

  depends_on "xz" unless Hardware::CPU.arm?
  depends_on "zstd" unless Hardware::CPU.arm?

  keg_only <<~KEG_ONLY_EOS
    it may interfere with another version of arm-gcc-bin.
    This is useful if you want to have multiple versions installed
  KEG_ONLY_EOS

  def install
    bin.install (Dir["bin/*"] - ["bin/arm-none-eabi-gdb-py"])
    prefix.install Dir["arm-none-eabi", "include", "lib", "libexec", "share"]
  end

  def caveats
    if Hardware::CPU.arm?
      <<~EOS
        arm-none-eabi-gdb-py links against python@3.9, which is end-of-life and will
        be removed from Homebrew in the future. It has been excluded from this
        formula to avoid a broken linkage. If you need up-to-date GDB Python
        scripting support, install a recompiled toolchain manually from:
          https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases
      EOS
    else
      <<~EOS
        Note: arm-gnu-toolchain 14.3.rel1 is not available for x86_64.
        This formula installs 14.2.rel1 on x86_64 instead.
      EOS
    end
  end

  test do
    # x86_64 ships 14.2.rel1 because there is no upstream 14.3 build for that arch.
    expected_version = Hardware::CPU.arm? ? version.to_s : "14.2.rel1"
    assert_match "Arm GNU Toolchain #{expected_version}".downcase,
                 shell_output("#{opt_prefix}/bin/arm-none-eabi-gcc --version").downcase
  end
end
