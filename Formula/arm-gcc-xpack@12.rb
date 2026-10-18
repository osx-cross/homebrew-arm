# frozen_string_literal: true

class ArmGccXpackAT12 < Formula
  @arch = Hardware::CPU.arm? ? "arm64" : "x64"
  @tar_file_sha = if Hardware::CPU.arm?
    "507926ba1e37e6fcae2a7499559cffd6da015b93145ff7657aafca9ef097d683"
  else
    "a90e6d0cb74c61e8d06e586f32bcd1983789da15808a8aa64658c1f5e892d2dc"
  end

  desc "Pre-built xPack GNU toolchain for Arm Cortex-M/R with Python GDB support"
  homepage "https://xpack-dev-tools.github.io/arm-none-eabi-gcc-xpack/"
  url "https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/download/v12.3.1-1.2/xpack-arm-none-eabi-gcc-12.3.1-1.2-darwin-#{@arch}.tar.gz"
  version "12.3.1-1.2"
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
