require 'formula'

class ArmGccBin < Formula

    homepage 'https://developer.arm.com/open-source/gnu-toolchain/gnu-rm'
    url 'https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2018q2/gcc-arm-none-eabi-7-2018-q2-update-mac.tar.bz2'
    sha256 'c1c4af5226d52bd1b688cf1bd78f60eeea53b19fb337ef1df4380d752ba88759'
    version '7-2018-q2-update'

    def install
        bin.install Dir["bin/*"]
        prefix.install Dir["arm-none-eabi", "lib", "share"]
    end
end
