#!/bin/bash
# Copyright (c) 2015-2019 Daniel Gustafsson <daniel@yesql.se>
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
TEMPLATE=worklog.template
T_PATH=`date "+%Y/%m-%B"`
T_FILE=$T_PATH/`date "+%d-%A"`.md
Y_FILE=`date -j -v-1d "+%Y/%m-%B/%d-%A"`.md
EDITOR_FLAGS=

echo "Creating daily entry for $TODAY in $T_PATH"

mkdir -p $T_PATH
if [[ ! -f $T_FILE ]] || [[ ! -s $T_FILE ]]; then
	if [[ ! -f $TEMPLATE ]]; then
		printf "# $TODAY #\n\n" > $T_FILE
	else
		sed "s/<<TODAY>>/$TODAY/" < worklog.template > $T_FILE
		if [[ -f worklog.todo ]]; then
			mv $T_FILE temp
			sed -e "s/<<TODO>>/$(cat worklog.todo)/" < temp > $T_FILE
		fi
	fi
	git add $T_FILE
	git commit -m "Initial commit for $TODAY"
fi

if [[ -f $Y_FILE ]]; then
	ln -f -s $Y_FILE yesterday
	if [[ "$EDITOR" == "vim" ]]; then
		EDITOR_FLAGS+=" -p "
		P_FILE=yesterday
	fi
else
	rm -f yesterday
fi

$EDITOR $EDITOR_FLAGS $T_FILE $P_FILE
git add $T_FILE
git commit -m "Work done on $TODAY"
