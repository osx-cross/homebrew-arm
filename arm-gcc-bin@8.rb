require 'formula'

class ArmGccBinAT8 < Formula
    desc 'GNU Arm Embedded Toolchain - Pre-built GNU toolchain for Arm Cortex-M and Cortex-R processors'
    homepage 'https://developer.arm.com/open-source/gnu-toolchain/gnu-rm'

    url 'https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2019q3/RC1.1/gcc-arm-none-eabi-8-2019-q3-update-mac.tar.bz2'
    sha256 'fc235ce853bf3bceba46eff4b95764c5935ca07fc4998762ef5e5b7d05f37085'
    version '8-2019-q3-update'

    keg_only "it may interfere with another version of arm-gcc-bin. This is useful if you want to have multiple versions installed on the same machine."

    def install
        bin.install Dir["bin/*"]
        prefix.install Dir["arm-none-eabi", "lib", "share"]
    end
end
