require 'formula'

class ArmGccBin < Formula

    homepage 'https://developer.arm.com/open-source/gnu-toolchain/gnu-rm'
    url 'https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2017q4/gcc-arm-none-eabi-7-2017-q4-major-mac.tar.bz2'
    sha256 '89b776c7cf0591c810b5b60067e4dc113b5b71bc50084a536e71b894a97fdccb'
    version '7-2017-q4-major'

    def install
        bin.install Dir["bin/*"]
        prefix.install Dir["arm-none-eabi", "lib", "share"]
    end
end
