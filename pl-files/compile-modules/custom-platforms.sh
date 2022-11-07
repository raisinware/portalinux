#!/bin/sh
case $1 in
    ## Nintendo Platforms:
    3ds) # Nintendo 3DS and New Nintendo 3DS
		specific_arch="armv6k"
		dist="musl"
		kernel_url="https://github.com/raisinware/linux-raisin/archive/refs/heads/3ds-5.15.tar.gz"
		kdefconfig="nintendo3ds_defconfig"
		;;
	gc | gamecube) # Nintendo GameCube
	    specific_arch="powerpc"
		dist="musl"
		kernel_url="https://github.com/neagix/wii-linux-ngx/archive/refs/heads/stable-v3.x.tar.gz"
		;;
	wii) # Nintendo Wii
		specific_arch="powerpc"
		dist="musl"
		kernel_url="https://github.com/neagix/wii-linux-ngx/archive/refs/heads/stable-v3.14.19.tar.gz"
		;;
	m1)
		specific_arch="aarch64"
		dist="gnu"
		kernel_url="https://github.com/AsahiLinux/linux/archive/refs/heads/asahi.tar.gz"
		;;
esac
