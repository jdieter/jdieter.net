#!/bin/sh
OLD=""
NEW="!@!!@@!!!!!!!@@@!@!@!"
if [ "$1" == "" ] || [ "$2" == "" ]; then
    echo "Usage: $0 <old file> <new file>"
    exit 1
fi
if [ ! -e "$1" ] || [ ! -e "$2" ]; then
    exit 0
fi
if [ -d "$2" ]; then
    echo "$2"
fi
if [ -d "$1" ] && [ -d "$2" ]; then
    OLD=`ls $1`
    NEW=`ls $2`
    if [ "$OLD" == "$NEW" ]; then
        touch -r "$1" "$2"
    fi
fi
if [ -f "$1" ] && [ -f "$2" ]; then
    diff -q "$1" "$2"
    if [ "$?" -eq "0" ]; then
        touch -r "$1" "$2"
    fi
fi
