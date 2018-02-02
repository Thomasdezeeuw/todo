#!/bin/bash

# Copyright 2017 Thomas de Zeeuw
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license <LICENSE-MIT
# or http://opensource.org/licenses/MIT>, at your option. This file may not be
# used, copied, modified, or distributed except according to those terms.

set -eu
source setup.sh

export TODO_ROOT="$TEST_DIR/open"
export EDITOR="echo"

OUTPUT=$(../todo.sh)
if [[ "$OUTPUT" != "test_repos/open/TODO" ]]; then
	fail "open: expected to open the global todo lists, but opened '$OUTPUT'"
fi

OUTPUT=$(../todo.sh abc)
if [[ "$OUTPUT" != "test_repos/open/abc.TODO" ]]; then
	fail "open: expected to open the abc todo lists, but opened '$OUTPUT'"
fi

OUTPUT=$(../todo.sh "with space")
if [[ "$OUTPUT" != "test_repos/open/with space.TODO" ]]; then
	fail "open: expected to open the with space todo lists, but opened '$OUTPUT'"
fi

# File shouldn't be created.
EDITOR=rm ../todo.sh def

# TODO: test emptying todo file, should be removed.

OUTPUT=$(../todo.sh ls)
EXPECTED="TODO
abc
with space"

if [[ "$OUTPUT" != "$EXPECTED" ]]; then
	fail "open: expected the global todo file to be made, but got '$OUTPUT'"
fi

N_COMMITS=$(cd $TODO_ROOT && git rev-list --all --count)
EXPECTED="3"

if [[ "$N_COMMITS" != "$EXPECTED" ]]; then
	fail "open: expected $EXPECTED commits, but got $N_COMMITS"
fi
