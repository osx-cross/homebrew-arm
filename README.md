# homebrew-arm

This repository contains the GNU Toolchain for ARM Embedded Processors as formulae for [Homebrew](https://brew.sh).

## About

This is a Homebrew binary repository for the pre-built GNU toolchain for ARM Cortex-M and Cortex-R processors (Cortex-M0/M0+/M3/M4/M7/M23/M33, Cortex-R4/R5/R7/R8 and more).


## Installing the formulae

First `brew tap osx-cross/arm` and then `brew install <formula>`.

### Using the prebuilt binaries

To install the entire ARM toolchain, do:

```bash
# tap the repository
$ brew tap osx-cross/arm

# install the toolchain
$ brew install arm-gcc-bin
```

### Building from source

*This is not available yet, but we are working on it ;)*


## Docs

- `brew help`, `man brew`, or check [Homebrew's documentation](https://docs.brew.sh).
- [GNU ARM Embedded Toolchain](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/)
