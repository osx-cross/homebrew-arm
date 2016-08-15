# homebrew-arm

This repository contains the GNU Toolchain for ARM Embedded Processors as formulae for [Homebrew](http://brew.sh).

## About

Pre-built GNU toolchain from ARM Cortex-M & Cortex-R processors (Cortex-M0/M0+/M3/M4/M7, Cortex-R4/R5/R7).

As part of its ongoing commitment to maintaining and enhancing GCC compiler support for the ARM architecture, ARM is maintaining a GNU toolchain with a GCC source branch targeted at Embedded ARM Processors, namely Cortex-R/Cortex-M processor families, covering Cortex-M0, Cortex-M3, Cortex-M4, Cortex-M0+, Cortex-M7, Cortex-R4, Cortex-R5 and Cortex-R7. As part of this, ARM will, at regular intervals, release binaries pre-built and tested from the ARM embedded branch. The improvements will be freely available for integration into 3rd party toolchains, and for direct download by end-users.

ARM employees are maintaining this project. Contributing to this project should be via GCC trunk http://gcc.gnu.org and binutils trunk http://www.gnu.org/software/binutils/. This launchpad project is for communication and downloading. No code change is done in lp project.

For Ubuntu 10.04/12.04/13.04 32/64-bit user, PPA is available at https://launchpad.net/~terry.guo/+archive/gcc-arm-embedded.

Questions should be asked at https://answers.launchpad.net/gcc-arm-embedded

Bug can be filed at https://bugs.launchpad.net/gcc-arm-embedded/+filebug. It is highly encouraged to ask question first before filing a bug.

## Current Versions

-   `gcc 5.4.1`
-   `binutils 2.26`
-   `gdb 7.10.1`

## Installing the formulae

First, just `brew tap osx-cross/arm` and then `brew install <formula>`.

### Using the prebuilt binaries

To install the entire ARM toolchain, do:

``` {.bash}
# to tap the repository
$ brew tap osx-cross/arm
# to install the toolchain
$ brew install arm-gcc-bin
```

### Building from source

*This is not available yet, but we are working on it ;)*

## Docs

-   `brew help`, `man brew`, or the Homebrew [wiki](http://wiki.github.com/mxcl/homebrew).
-   [GNU Tools for ARM Embedded Processors](https://launchpad.net/gcc-arm-embedded)

