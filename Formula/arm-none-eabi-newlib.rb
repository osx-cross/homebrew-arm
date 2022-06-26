class ArmNoneEabiNewlib < Formula
  desc "GNU Tools for ARM Embedded Processors - Newlib"
  homepage "https://sourceware.org/newlib/"

  url "https://sourceware.org/pub/newlib/newlib-3.3.0.tar.gz"
  sha256 "58dd9e3eaedf519360d92d84205c3deef0b3fc286685d1c562e245914ef72c66"

  depends_on "gmp" => :build
  depends_on "isl" => :build
  depends_on "libmpc" => :build
  depends_on "mpfr" => :build
  depends_on "arm-none-eabi-binutils"

  resource "minimal-gcc" do
    url "https://ftp.gnu.org/gnu/gcc/gcc-8.5.0/gcc-8.5.0.tar.xz"
    mirror "https://ftpmirror.gnu.org/gcc/gcc-8.5.0/gcc-8.5.0.tar.xz"
    sha256 "d308841a511bb830a6100397b0042db24ce11f642dab6ea6ee44842e5325ed50"
  end

  arm_prefix = prefix/"arm-none-eabi"

  def install
    # GCC will suffer build errors if forced to use a particular linker.
    ENV.delete "LD"

    # Even when suffixes are appended, the info pages conflict when
    # install-info is run so pretend we have an outdated makeinfo
    # to prevent their build.
    ENV["gcc_cv_prog_makeinfo_modern"] = "no"

    resource("minimal-gcc").stage do
      args = %W[
        --prefix=/
        --target=arm-none-eabi
        --enable-languages=c
        --with-ld=#{Formula["arm-none-eabi-binutils"].opt_bin/"arm-none-eabi-ld"}
        --with-as=#{Formula["arm-none-eabi-binutils"].opt_bin/"arm-none-eabi-as"}
        --disable-nls
        --disable-libssp
        --disable-shared
        --disable-threads
        --disable-libgomp
        --disable-werror
        --disable-lto
        --disable-libffi
        --disable-decimal-float
        --disable-libmudflap
        --disable-libquadmath
        --disable-libstdcxx-pch
        --disable-libsanitizer
        --disable-tls
        --enable-multilib
        --enable-interwork
        --without-headers
        --with-libelf
        --with-newlib
        --with-multilib-list=rmprofile
        --with-system-zlib
        --with-sysroot=#{prefix}
        --with-build-sysroot=#{buildpath.parent/"gcc-install"}
      ]

      # Avoid reference to sed shim
      args << "SED=/usr/bin/sed"

      mkdir "build" do
        system "../configure", *args

        # Use -headerpad_max_install_names in the build,
        # otherwise updated load commands won't fit in the Mach-O header.
        # This is needed because `gcc` avoids the superenv shim.
        system "make", "all-gcc", "BOOT_LDFLAGS=-Wl,-headerpad_max_install_names"
        system "make", "DESTDIR=#{buildpath.parent/"gcc-install"}", "install-gcc"
      end
    end

    ENV["PATH"] = "#{buildpath.parent/"gcc-install/bin"}:#{ENV["PATH"]}"

    # `make install` complains if these dirs do not already exist, for some reason
    mkdir_p arm_prefix/"lib/arm/v5te/hard"
    mkdir_p arm_prefix/"lib/arm/v5te/softfp"
    mkdir_p arm_prefix/"lib/thumb/nofp"
    ["v6-m", "v7", "v7-m", "v7e-m", "v8-m.base", "v8-m.main"].each do |v|
      mkdir_p arm_prefix/"lib/thumb/#{v}/nofp"
    end
    ["v7+fp", "v7e-m+fp", "v7e-m+dp", "v8-m.main+fp", "v8-m.main+dp"].each do |v|
      mkdir_p arm_prefix/"lib/thumb/#{v}/hard"
      mkdir_p arm_prefix/"lib/thumb/#{v}/softfp"
    end


    mkdir "build-nano" do
      args = %W[
        --target=arm-none-eabi
        --prefix=#{prefix}
        --disable-newlib-supplied-syscalls
        --enable-newlib-reent-small
        --enable-newlib-retargetable-locking
        --disable-newlib-fvwrite-in-streamio
        --disable-newlib-fseek-optimization
        --disable-newlib-wide-orient
        --enable-newlib-nano-malloc
        --disable-newlib-unbuf-stream-opt
        --enable-lite-exit
        --enable-newlib-global-atexit
        --enable-newlib-nano-formatted-io
        --disable-nls
      ]

      system "../configure", *args
      system "make"
      system "make", "install"

      (arm_prefix/"lib").glob("**/lib{c,g,rdimon}.a").each do |f|
        mv f, f.sub(".a", "_nano.a")
      end
      mkdir_p arm_prefix/"include/newlib-nano"
      mv arm_prefix/"include/newlib.h", arm_prefix/"include/newlib-nano/newlib.h"
    end

    mkdir "build" do
      args = %W[
        --target=arm-none-eabi
        --prefix=#{prefix}
        --enable-newlib-io-long-long
        --enable-newlib-io-c99-formats
        --enable-newlib-register-fini
        --enable-newlib-retargetable-locking
        --disable-newlib-supplied-syscalls
        --disable-nls
      ]

      system "../configure", *args
      system "make"
      system "make", "install"

      (arm_prefix/"lib").glob("**/*.{a,o}").each do |f|
        system "arm-none-eabi-objcopy", "-R", ".comment", "-R", ".note", "-R", ".debug_info", "-R", ".debug_aranges",
               "-R", ".debug_pubnames", "-R", ".debug_pubtypes", "-R", ".debug_abbrev", "-R", ".debug_line",
               "-R", ".debug_str", "-R", ".debug_ranges", "-R", ".debug_loc", f.to_s
      end
    end
  end

  test do
    assert_predicate (arm_prefix/"lib").glob("**/lib{c,g,rdimon}.a"), :any?
    assert_predicate (arm_prefix/"lib").glob("**/lib{c,g,rdimon}_nano.a"), :any?
  end
end
