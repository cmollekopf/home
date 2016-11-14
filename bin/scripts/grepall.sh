#!/bin/bash
for var in "$@"
do
    echo $var
    if [[ $resultset ]]; then
        echo "first"
        resultset=`grep -n -e "$var" testfile`
        echo "1: $resultset"
    else
        filter=`grep -n -e "$var" testfile`
        echo "filter $filter"
        for line in $filter
        do
            tempresult=$tempresult`grep -v -e $line $resultset`
        done
        resultset=$tempresult

        echo "2: $resultset"
        # for line in `grep -n 'PATTERN' file`
        # do
        #     echo ${line}
        # done
    fi
done
