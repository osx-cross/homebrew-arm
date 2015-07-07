require 'formula'

class ArmGcc < Formula

    homepage 'https://launchpad.net/gcc-arm-embedded'
    url 'https://launchpad.net/gcc-arm-embedded/4.9/4.9-2015-q2-update/+download/gcc-arm-none-eabi-4_9-2015q2-20150609-mac.tar.bz2'
    sha256 '48841185eefa482f0338059dd779b3edf832521ccd05811d557ef4a2807b8284'
    version '4.9.3'

    def install
        bin.install Dir["bin/*"]
        prefix.install Dir["arm-none-eabi", "lib", "share"]
    end
end

