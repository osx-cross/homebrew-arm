# frozen_string_literal: true

class ArmGccXpackAT11 < Formula
  @arch = Hardware::CPU.arm? ? "arm64" : "x64"
  @tar_file_sha = if Hardware::CPU.arm?
    "99de78184f5548c65b980130c9438a31a602ddbbe9515f3d82bf000b67f8c835"
  else
    "16dd4af277c488eae8a1f7bc8348f772fb0442946d767ea1ee77485ffe2ff848"
  end

  desc "Pre-built xPack GNU toolchain for Arm Cortex-M/R with Python GDB support"
  homepage "https://xpack-dev-tools.github.io/arm-none-eabi-gcc-xpack/"
  url "https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/download/v11.3.1-1.1/xpack-arm-none-eabi-gcc-11.3.1-1.1-darwin-#{@arch}.tar.gz"
  version "11.3.1-1.1"
  sha256 @tar_file_sha

  keg_only <<~KEG_ONLY_EOS
    it may interfere with another version of arm-gcc-bin or arm-gcc-xpack.
    This is useful if you want to have multiple versions installed
  KEG_ONLY_EOS

  def install
    # arm-none-eabi-gdb-py3 embeds Python and needs the bundled lib/python3.x
    # next to it. Keep the whole tree private in libexec, so that the bundled
    # Python is not linked into the Homebrew prefix where it breaks other Pythons.
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
    # arm-gcc-bin used to name the Python GDB arm-none-eabi-gdb-py
    bin.install_symlink libexec/"bin/arm-none-eabi-gdb-py3" => "arm-none-eabi-gdb-py"
  end

  test do
    assert_match "xPack GNU Arm Embedded GCC", shell_output("#{bin}/arm-none-eabi-gcc --version")
    (testpath/"test.c").write "int main(void) { return 0; }"
    system bin/"arm-none-eabi-gcc", "-mcpu=cortex-m4", "--specs=nosys.specs", "test.c", "-o", "test.elf"
    assert_match "ok", shell_output("#{bin}/arm-none-eabi-gdb-py3 -batch -ex 'python import ssl; print(\"ok\")'")
  end
end
