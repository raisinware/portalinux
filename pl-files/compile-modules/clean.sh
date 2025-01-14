# SPDX-License-Identifier: GPL-2.0-or-later

_pl_clean(){
	set +e
	mode=2

	if [ "$1" != "" ]; then
		mode="$1"
	fi

	if [ $mode -lt 4 ]; then
		for i in $(ls "$build"); do
			printf "Cleaning $i..."
			if [ -d "$build/$i/build" ]; then
				if [ $mode -eq 1 ]; then
					cd "$build/$i/build"
					make -s clean >/dev/null 2>&1
					shift
				else
					rm -rf $build/$i/build
				fi
			elif [ -r $build/$i/Makefile ]; then
				cd $build/$i
				make -s clean >/dev/null 2>&1
				make -s distclean >/dev/null 2>&1
			fi
			echo "Done."
		done

		if [ $mode -gt 2 ]; then
			printf "Deleting output directory..."
			rm -rf "$output"
			echo "Done."
			shift
		fi
		rm -f "$logfile"
	else
		rm -rfv "$build" "$output" "$logfile"
		if [ $(echo "$2" | grep "no-rm-t" -c) -ne 0 ]; then
			shift
		else
			rm -rfv "$pldir/tarballs"
		fi
	fi
}
