cd() {
	builtin cd "$@"
	IS_BR2=$(pwd | grep buildroot)
	if [ "$IS_BR2" != "" ]; then
		BR2=$(pwd | sed 's|.*buildroot/\([^/]*\).*|\1|')
		if [ "$BR2" == "trunk" ] || [ "$BR2" == "real_trunk" ]; then
			branch="trunk"
		elif [ "$BR2" == "bromo" ]; then
			branch=$BR2
		else
			branch=$(pwd | sed 's|.*buildroot/platinabrcm-branch-\([^/]*\).*|\1|')
		fi
		PS1='${debian_chroot:+($debian_chroot)}\h:\[\e[01;33m\]\W\[\e[m\] \[\e[01;32m\]\u\[\e[m\] \[\e[01;34m\][$branch]\[\e[m\] \$ '
	else
		PS1='${debian_chroot:+($debian_chroot)}\h:\[\e[01;33m\]\W\[\e[m\] \[\e[01;32m\]\u\[\e[m\] \$ '
	fi
}

goto_print_usage() {
	echo -e "Usage: goto branch/trunk [branch_version]"
	echo -e "Ex: goto branch 2.4.0"
	return 0
}

goto() {
	IS_BR2=$(pwd | grep buildroot)
	if [ "$IS_BR2" == "" ]; then
		echo "You're not inside a buildroot folder"
		return 1
	fi
	if [ "$1" == "" ]; then
		goto_print_usage
	fi
	if [ "$1" == "branch" ] || [ "$1" == "tag" ]; then
		if [ "$2" == "" ]; then
			goto_print_usage
		fi
		NEW_BR2=platinabrcm-$1-$2
		BUILD_DIR=platinabrcm-$2-bridge
	else
		NEW_BR2=$1
		BUILD_DIR=platinabrcm-bridge
	fi

	SED_ARG="s|\(^.*buildroot/\)\([^/]*\)\(.*\)|\1$NEW_BR2\3|"
	NEW_PATH=$(pwd | sed -e $SED_ARG)
	IN_PKG=$(echo $NEW_PATH | grep 'bridge')
	if [ "IN_PKG" != "" ]; then
		SED_ARG="s|\(^.*project_build_mips/\)\([^/]*\)\(.*\)|\1$BUILD_DIR\3|"
		NEW_PATH=$(echo $NEW_PATH | sed -e $SED_ARG)
	fi
	if [ ! -d $NEW_PATH ]; then
		echo -e $NEW_PATH
		echo -e "$NEW_BR2 not found!"
		return 1
	fi

	ACTUAL_BR2=$(pwd | sed 's|.*buildroot/\([^/]*\).*|\1|')
	echo -e "Switching from $ACTUAL_BR2 to $NEW_BR2"
#	echo -e $NEW_PATH
	cd $NEW_PATH
}

function settitle() {
	if [ "$1" == "lastcmd" ]; then
		trap 'echo -ne "\033]0;$BASH_COMMAND\007"' DEBUG
	else
		printf "\033]0;%s\007" "$1"
	fi
}

function f() {
	find -name "$1" -exec gvim '{}' \;
}
