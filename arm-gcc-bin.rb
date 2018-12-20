require 'formula'

class ArmGccBin < Formula

    homepage 'https://developer.arm.com/open-source/gnu-toolchain/gnu-rm'
    url 'https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-mac.tar.bz2'
    sha256 '0b528ed24db9f0fa39e5efdae9bcfc56bf9e07555cb267c70ff3fee84ec98460'
    version '8-2018-q4-major'

    def install
        bin.install Dir["bin/*"]
        prefix.install Dir["arm-none-eabi", "lib", "share"]
    end
end
