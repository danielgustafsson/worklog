#!/bin/bash
# Copyright (c) 2015 Daniel Gustafsson <daniel@yesql.se>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

TODAY=`date "+%Y-%m-%d"`
T_PATH=`date "+%Y/%m-%B"`
T_FILE=$T_PATH/`date "+%d-%A"`.md

echo "Creating daily entry for $TODAY in $T_PATH"

mkdir -p $T_PATH
if [[ ! -f $T_FILE ]] || [[ ! -s $T_FILE ]]; then
	printf "# $TODAY #\n* Location:\n* Start time:\n* Weekly target:\n\n## Greenplum\n\n## PostgreSQL Community\n\n" > $T_FILE
	git add $T_FILE
	git commit -m "Initial commit for $TODAY"
fi

$EDITOR $T_FILE
git add $T_FILE
git commit -m "Work done on $TODAY"
