require 'formula'

class ArmGccBin < Formula

    homepage 'https://launchpad.net/gcc-arm-embedded'
    url 'https://launchpad.net/gcc-arm-embedded/5.0/5-2015-q4-major/+download/gcc-arm-none-eabi-5_2-2015q4-20151219-mac.tar.bz2'
    sha256 '41056ffeba4bcb5bbea13185461a1269613ac13321fbda3e7dc59ee664ee3f06'
    version '5-2015-q4-major'

    def install
        bin.install Dir["bin/*"]
        prefix.install Dir["arm-none-eabi", "lib", "share"]
    end
end

