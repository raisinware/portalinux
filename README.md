# PortaLinux

A Linux distribution that tries to be as lightweight and small as possible
while also being as secure and compatible with as many components as it can.

# Minimum Requirements

- CPU: Intel 80486
- RAM: 128* MiB
- HDD: 12** MiB

**These metrics may vary depending on the kernel config and the C library used**

# Build Requirements

## Build tools

- Make >= 4.x
- GCC >= 7
- Flex >= 2.x
- Bison >= 3.x
- Gawk >= 3.x/Busybox Awk >= 1.30.1
- Rsync (for Linux kernel headers)

## System Requirements

- CPU: Doesn't matter. If it turns on and can read at least 2GiB RAM and at
least 16GiB of storage, it will work
- RAM: 2GiB
- Storage: 10GiB

# Build instructions

Before building PortaLinux, you must initialize the script by running the
following:
```
./compile --init
```
This will download all of the necessary components to compile the target
toolchain, the target root filesystem and the target kernel.

Whenever you want to target a system different from the default, you must
change the compile target with the `--target-compile` option (`$arch` being
the target architecture and `$dist` being the distribution, `musl` and `gnu`
being the only valid options).
```
./compile --target-system $arch-$dist --init
```

Before you start compiling anything, make sure your `PATH` contains your
toolchain install path's bin folder as the first search path:
```
PATH=$toolchain_prefix/bin:$PATH
```

## Toolchain

To compile the target toolchain, run the following:
```
./compile --build toolchain
```
If targeting a different system from the default, use the `--target-system`
option to change the compile target.
```
./compile --target-system $arch-$dist --build toolchain
```

## Root Filesystem

To compile the target root filesystem, run the following:
```
./compile --build rootfs
```
If targeting a different system from the default, use the `--target-system`
option to change the compile target.
```
./compile --target-system $arch-$dist --build rootfs
```

## Extra Packages
To compile some extra packages for development, run the following:
```
./compile --build extra-pkgs
```
If targeting a different system from the default, use the `--target-system`
option to change the compile target.
```
./compile --target-system $arch-$dist --build extra-pkgs
```

## Kernel

Before compiling the kernel, you must configure it by running the following:
```
./compile --config-kernel
```
After you're done configuring the kernel, run the following:
```
./compile --build kernel
```

## Boot Initramfs Archive
To create an initramfs compressed cpio archive, run the following:
```
./compile --build boot-img
```
If you need to change the compression, you must add the compression utility as
a second argument to `--build`. If you need to run the compression tool with
flags, you'll need to enclose the compression command with the flags in quotes.
```
./compile --build $compression_tool
# or
./compile --build "$compression_tool_with_flags"
```
