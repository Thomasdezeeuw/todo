#!/bin/bash

# Copyright 2017 Thomas de Zeeuw
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license <LICENSE-MIT
# or http://opensource.org/licenses/MIT>, at your option. This file may not be
# used, copied, modified, or distributed except according to those terms.

set -eu
source setup.sh

export TODO_ROOT="$TEST_DIR/list"

../todo.sh
OUTPUT=$(../todo.sh list)
EXPECTED="# TODO "

if [[ "$OUTPUT" != "$EXPECTED" ]]; then
	fail "list: expected the file to contain '$EXPECTED', but got '$OUTPUT'"
fi


../todo.sh abc
OUTPUT=`../todo.sh list abc`
EXPECTED="# TODO abc"

if [[ "$OUTPUT" != "$EXPECTED" ]]; then
	fail "list: expected the file to contain '$EXPECTED', but got '$OUTPUT'"
fi
