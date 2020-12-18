require 'formula'

class ArmGccBinAT9 < Formula
    desc 'GNU Arm Embedded Toolchain - Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors'
    homepage 'https://developer.arm.com/open-source/gnu-toolchain/gnu-rm'

    url 'https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-mac.tar.bz2'

    sha256 'bbb9b87e442b426eca3148fa74705c66b49a63f148902a0ea46f676ec24f9ac6'
    version '9-2020-q2-update'

    keg_only "it may interfere with another version of arm-gcc-bin. This is useful if you want to have multiple versions installed on the same machine"

    def install
        bin.install Dir["bin/*"]
        prefix.install Dir["arm-none-eabi", "lib", "share"]
    end
end
