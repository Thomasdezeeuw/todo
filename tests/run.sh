#!/bin/bash

# Copyright 2017 Thomas de Zeeuw
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license <LICENSE-MIT
# or http://opensource.org/licenses/MIT>, at your option. This file may not be
# used, copied, modified, or distributed except according to those terms.

set -eu

export TODO_AUTO_SYNC=0
export TEST_DIR="test_repos"
export EDITOR="true"

# Go to the test directory.
cd $(dirname $0)

# Clean up the test repos.
rm -rf "$TEST_DIR"

# Run the tests.
./test_setup.sh
./test_list.sh
./test_open.sh
