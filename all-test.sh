#!/bin/bash

sout=`mktemp`
vim -c "UnitTest test_all.vim >$sout" -c "qall!"

cat $sout
status="$(cat $sout | tail -n 3 | head -n 1 | grep -o '0 failures, 0 errors')"

rm $sout; unset sout;
if [ "$status" == "" ];then
  exit 1
fi
