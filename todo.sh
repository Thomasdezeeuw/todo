#!/bin/bash

# Copyright 2017 Thomas de Zeeuw
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http:#www.apache.org/licenses/LICENSE-2.0> or the MIT license <LICENSE-MIT
# or http:#opensource.org/licenses/MIT>, at your option. This file may not be
# used, copied, modified, or distributed except according to those terms.

set -eu

TODO_AUTO_SYNC=${TODO_AUTO_SYNC:-"false"}
TODO_ROOT=${TODO_ROOT:-"~/.todo"}
EDTIOR=${EDITOR:-vim}

# Create the git repo, if needed.
setup() {
	mkdir -p $TODO_ROOT
	if [[ ! -f "$TODO_ROOT/.git/HEAD" ]]; then
		git init --quiet $TODO_ROOT
	fi
}

# Determine the list file based on an optional argument.
list_file_path() {
	# Either the global "TODO" file or "$name.TODO" file.
	if [ -z ${1+x} ]; then
		echo "TODO"
	else
		echo "$1.TODO"
	fi
}

open() {
	LIST_FILE_PATH=$(list_file_path ${1:-})
	LIST_FILE_FULL_PATH="$TODO_ROOT/$(list_file_path ${1:-})"

	# Setup a skeleton if the file doesn't exists.
	if [[ ! -f "$LIST_FILE_FULL_PATH" ]]; then
		if [ -z ${1+x} ]; then
			printf "# TODO \n\n\n" > $LIST_FILE_FULL_PATH
		else
			printf "# TODO $1\n\n\n" > $LIST_FILE_FULL_PATH
		fi
		(cd $TODO_ROOT && git add $LIST_FILE_PATH)
	fi

	# Open the users editor to allow them to edit the todo file.
	$EDITOR $LIST_FILE_FULL_PATH

	# If the file is empty we can remove it.
	if [[ ! -s $LIST_FILE_FULL_PATH ]]; then
		rm -f $LIST_FILE_FULL_PATH
	fi

	# Commit the changes.
	# TODO: improve commit message
	(cd $TODO_ROOT && git commit --quiet --all --message="Update todo list" || true)

	# Automatically sync the todo, if that is required.
	if [[ $TODO_AUTO_SYNC == "true" || $TODO_AUTO_SYNC == "1" ]]; then
		sync
	fi
}

# Call git push on the todo repo.
sync() {
	(cd $TODO_ROOT && git push --quiet)
}

setup

arg_1=${1:-}

case $arg_1 in
list)
	cat "$TODO_ROOT/$(list_file_path ${2:-})"
	;;
sync)
	sync
	;;
*)
	open $arg_1
	;;
esac
