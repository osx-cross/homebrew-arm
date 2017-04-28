require 'formula'

class ArmGccBin < Formula

    homepage 'https://developer.arm.com/open-source/gnu-toolchain/gnu-rm'
    url 'https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/6_1-2017q1/gcc-arm-none-eabi-6-2017-q1-update-mac.tar.bz2'
    sha256 'de4de95b09740272aa95ca5a43bb234ba29c323eddcad2ee34e901eebda910a2'
    version '6-2017-q1-update'

    def install
        bin.install Dir["bin/*"]
        prefix.install Dir["arm-none-eabi", "lib", "share"]
    end
end
