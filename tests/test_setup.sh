#!/bin/bash

# Copyright 2017 Thomas de Zeeuw
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license <LICENSE-MIT
# or http://opensource.org/licenses/MIT>, at your option. This file may not be
# used, copied, modified, or distributed except according to those terms.

set -eu
source setup.sh

export TODO_ROOT="$TEST_DIR/setup"

OUTPUT=$(../todo.sh ls)

if [[ "$OUTPUT" != "" ]]; then
	fail "setup: expected no todo lists, but got '$OUTPUT'"
fi

if [[ ! -f "$TODO_ROOT/.git/HEAD" ]]; then
	fail "setup: no git repo found in $TODO_ROOT"
fi
