# SPDX-License-Identifier: GPL-2.0-or-later

compile_kernel(){
	_get_pkg_names
	cd "$linux_dir"

	if [ ! -f .config ]; then
		echo "Error: Kernel has not been configured yet. Run $0 --config-kernel and try again"
		exit 4
	fi

	script -qeac "make CROSS_COMPILE=$compile_target- ARCH=$linux_arch -j$threads" "$logfile"

	modules_support=$(grep -w "CONFIG_MODULES" .config)
	if [ "$modules_support" != "" ] && [ "$(echo $modules_support | grep '#')" = "" ]; then
		script -qeac "make CROSS_COMPILE=$compile_target- ARCH=$linux_arch INSTALL_MOD_PATH=$output_rootfs modules_install" "$logfile"
	fi
	cp arch/$linux_arch/boot/dts/*.dtb "$output" 2>/dev/null || true
	cp arch/$linux_arch/boot/*Image "$output"
}

configure_kernel(){
	_get_pkg_names
	cd "$linux_dir"

	if [ "$2" != "" ]; then
		kdefconfig=$2
	fi

	if [ ! -f .config ]; then
		make CROSS_COMPILE=$compile_target- ARCH=$linux_arch $kdefconfig
	fi

	make ARCH=$linux_arch menuconfig
	exit 0
}
