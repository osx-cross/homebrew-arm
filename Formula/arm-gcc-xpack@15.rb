# frozen_string_literal: true

class ArmGccXpackAT15 < Formula
  @arch = Hardware::CPU.arm? ? "arm64" : "x64"
  @tar_file_sha = if Hardware::CPU.arm?
    "574082d35e49a2bcbdc355836b2a3ae5e5bb3b9456c9f5e37177db2ab4aad870"
  else
    "5be906a5194c3173e145a58048e5607ffff947773237802b93e55e23c415f1b6"
  end

  desc "Pre-built xPack GNU toolchain for Arm Cortex-M/R with Python GDB support"
  homepage "https://xpack-dev-tools.github.io/arm-none-eabi-gcc-xpack/"
  url "https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/download/v15.2.1-1.1/xpack-arm-none-eabi-gcc-15.2.1-1.1-darwin-#{@arch}.tar.gz"
  version "15.2.1-1.1"
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
