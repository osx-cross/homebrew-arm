class ArmNoneEabiGccAT9 < Formula
  desc "GNU Tools for ARM Embedded Processors - GCC"
  homepage "https://www.gnu.org/software/gcc/gcc.html"

  url "https://ftp.gnu.org/gnu/gcc/gcc-9.5.0/gcc-9.5.0.tar.xz"
  mirror "https://ftpmirror.gnu.org/gcc/gcc-9.5.0/gcc-9.5.0.tar.xz"
  sha256 "27769f64ef1d4cd5e2be8682c0c93f9887983e6cfd1a927ce5a0a2915a95cf8f"

  # The bottles are built on systems with the CLT installed, and do not work
  # out of the box on Xcode-only systems due to an incorrect sysroot.
  pour_bottle? do
    reason "The bottle needs the Xcode CLT to be installed."
    satisfy { MacOS::CLT.installed? }
  end

  keg_only "it might interfere with other version of arm-gcc.\n" \
           "This is useful if you want to have multiple version of arm-none-eabi-gcc\n" \
           "installed on the same machine"

  depends_on "arm-none-eabi-binutils"

  depends_on "gmp"
  depends_on "isl"
  depends_on "libmpc"
  depends_on "mpfr"

  uses_from_macos "zlib"

  # GCC bootstraps itself, so it is OK to have an incompatible C++ stdlib
  cxxstdlib_check :skip

  resource "newlib" do
    url "https://sourceware.org/pub/newlib/newlib-3.3.0.tar.gz"
    sha256 "58dd9e3eaedf519360d92d84205c3deef0b3fc286685d1c562e245914ef72c66"
  end

  # This patch fixes a GCC compilation error on Apple ARM systems by adding
  # a defintion for host_hooks.  Patch comes from
  # https://github.com/riscv/riscv-gnu-toolchain/issues/800#issuecomment-808722775
  patch do
    url "https://gist.githubusercontent.com/DavidEGrayson/88bceb3f4e62f45725ecbb9248366300/raw/c1f515475aff1e1e3985569d9b715edb0f317648/gcc-11-arm-darwin.patch"
    sha256 "c4e9df9802772ddecb71aa675bb9403ad34c085d1359cb0e45b308ab6db551c6"
  end

  def install
    arm_prefix = prefix/"arm-none-eabi"

    # GCC will suffer build errors if forced to use a particular linker.
    ENV.delete "LD"

    # Even when suffixes are appended, the info pages conflict when
    # install-info is run so pretend we have an outdated makeinfo
    # to prevent their build.
    ENV["gcc_cv_prog_makeinfo_modern"] = "no"

    resource("newlib").stage do
      mkdir "gcc-build" do
        min_args = %W[
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
        min_args << "SED=/usr/bin/sed"

        system "#{buildpath}/configure", *min_args

        # Use -headerpad_max_install_names in the build,
        # otherwise updated load commands won't fit in the Mach-O header.
        # This is needed because `gcc` avoids the superenv shim.
        system "make", "all-gcc", "BOOT_LDFLAGS=-Wl,-headerpad_max_install_names"
        system "make", "DESTDIR=#{buildpath.parent/"gcc-install"}", "install-gcc"
      end

      ENV["PATH"] = "#{buildpath.parent/"gcc-install/bin"}:#{ENV["PATH"]}"

      # `make install` complains if these dirs do not already exist, for some reason
      (arm_prefix/"lib/arm/v5te/hard").mkpath
      (arm_prefix/"lib/arm/v5te/softfp").mkpath
      (arm_prefix/"lib/thumb/nofp").mkpath
      ["v6-m", "v7", "v7-m", "v7e-m", "v8-m.base", "v8-m.main"].each do |v|
        (arm_prefix/"lib/thumb/#{v}/nofp").mkpath
      end
      ["v7+fp", "v7e-m+fp", "v7e-m+dp", "v7-r+fp.sp", "v8-m.main+fp", "v8-m.main+dp"].each do |v|
        (arm_prefix/"lib/thumb/#{v}/hard").mkpath
        (arm_prefix/"lib/thumb/#{v}/softfp").mkpath
      end

      mkdir "build-nano" do
        newlib_args_nano = %W[
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

        system "../configure", *newlib_args_nano
        system "make"
        system "make", "install"

        (arm_prefix/"lib").glob("**/lib{c,g,rdimon}.a").each do |f|
          mv f, f.sub(".a", "_nano.a")
        end
        (arm_prefix/"include/newlib-nano").mkpath
        mv arm_prefix/"include/newlib.h", arm_prefix/"include/newlib-nano/newlib.h"
      end

      mkdir "build" do
        newlib_args = %W[
          --target=arm-none-eabi
          --prefix=#{prefix}
          --enable-newlib-io-long-long
          --enable-newlib-io-c99-formats
          --enable-newlib-register-fini
          --enable-newlib-retargetable-locking
          --disable-newlib-supplied-syscalls
          --disable-nls
        ]

        system "../configure", *newlib_args
        system "make"
        system "make", "install"
      end
    end

    languages = ["c", "c++"]

    pkgversion = "Homebrew ARM GCC #{pkg_version}".strip

    args = %W[
      --target=arm-none-eabi
      --prefix=#{prefix}
      --libdir=#{lib}/arm-none-eabi-gcc/#{version.major}
      --with-python-dir=share/gcc-arm-none-eabi

      --enable-languages=#{languages.join(",")}

      --with-ld=#{Formula["arm-none-eabi-binutils"].opt_bin/"arm-none-eabi-ld"}
      --with-as=#{Formula["arm-none-eabi-binutils"].opt_bin/"arm-none-eabi-as"}

      --enable-plugins
      --disable-decimal-float
      --disable-libffi
      --disable-libgomp
      --disable-libmudflap
      --disable-libquadmath
      --disable-libssp
      --disable-libstdcxx-pch
      --disable-nls
      --disable-shared
      --disable-threads
      --disable-tls
      --disable-libada
      --with-system-zlib
      --with-newlib
      --with-sysroot=#{prefix}
      --with-gmp
      --with-mpfr
      --with-mpc
      --with-isl
      --with-libelf
      --with-multilib-list=rmprofile
      --enable-checking=release

      --with-pkgversion=#{pkgversion}
      --with-bugurl=https://github.com/osx-cross/homebrew-arm/issues
    ]

    # Avoid reference to sed shim
    args << "SED=/usr/bin/sed"

    mkdir "build" do
      system "../configure", *args

      ENV["CFLAGS_FOR_TARGET"] = "-g -Os -ffunction-sections -fdata-sections"
      ENV["CXXFLAGS_FOR_TARGET"] = "-g -Os -ffunction-sections -fdata-sections"

      # Use -headerpad_max_install_names in the build,
      # otherwise updated load commands won't fit in the Mach-O header.
      # This is needed because `gcc` avoids the superenv shim.
      system "make", "INHIBIT_LIBC_CFLAGS='-DUSE_TM_CLONE_REGISTRY=0'",
                     "BOOT_LDFLAGS=-Wl,-headerpad_max_install_names"
      system "make", "install"
    end

    mkdir "build-nano" do
      system "../configure", *args

      ENV["CFLAGS_FOR_TARGET"] = "-g -Os -ffunction-sections -fdata-sections -fno-exceptions"
      ENV["CXXFLAGS_FOR_TARGET"] = "-g -Os -ffunction-sections -fdata-sections -fno-exceptions"

      system "make", "INHIBIT_LIBC_CFLAGS='-DUSE_TM_CLONE_REGISTRY=0'",
                     "BOOT_LDFLAGS=-Wl,-headerpad_max_install_names"
      system "make", "DESTDIR=#{buildpath.parent}/nano-install", "install"
    end

    # we need only libstdc nano files
    multilibs = `#{bin}/arm-none-eabi-gcc -print-multi-lib`.split("\n")
    multilibs.each do |multilib|
      m_dir = multilib.split(";").first.chomp
      from_dir = buildpath.parent/"nano-install"/arm_prefix/"lib"/m_dir
      to_dir = arm_prefix/"lib"/m_dir
      cp from_dir/"libstdc++.a", to_dir/"libstdc++_nano.a"
      cp from_dir/"libsupc++.a", to_dir/"libsupc++_nano.a"
    end

    # strip target binaries
    (arm_prefix/"lib").glob("**/*.{a,o}").each do |f|
      system "arm-none-eabi-objcopy", "-R", ".comment", "-R", ".note", "-R", ".debug_info", "-R", ".debug_aranges",
             "-R", ".debug_pubnames", "-R", ".debug_pubtypes", "-R", ".debug_abbrev", "-R", ".debug_line",
             "-R", ".debug_str", "-R", ".debug_ranges", "-R", ".debug_loc", f.to_s
    end
    (prefix/"lib").glob("**/*.{a,o}").each do |f|
      system "arm-none-eabi-objcopy", "-R", ".comment", "-R", ".note", "-R", ".debug_info", "-R", ".debug_aranges",
             "-R", ".debug_pubnames", "-R", ".debug_pubtypes", "-R", ".debug_abbrev", "-R", ".debug_line",
             "-R", ".debug_str", "-R", ".debug_ranges", "-R", ".debug_loc", f.to_s
    end

    # info and man7 files conflict with native gcc
    info.rmtree
    man7.rmtree
  end

  test do
    assert_match "Homebrew ARM GCC #{version}", `#{prefix}/bin/arm-none-eabi-gcc --version`
  end
end
