require 'formula'

class ArmGccBin < Formula
	desc 'GNU Arm Embedded Toolchain - Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors'
    homepage 'https://developer.arm.com/open-source/gnu-toolchain/gnu-rm'
    
    url 'https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/RC2.1/gcc-arm-none-eabi-9-2019-q4-major-mac.tar.bz2'
    sha256 '1249f860d4155d9c3ba8f30c19e7a88c5047923cea17e0d08e633f12408f01f0'
    version '8-2019-q3-update'

    def install
        bin.install Dir["bin/*"]
        prefix.install Dir["arm-none-eabi", "lib", "share"]
    end
end

