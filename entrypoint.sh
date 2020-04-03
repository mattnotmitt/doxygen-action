#!/bin/sh
if [ ! -f $1 ]; then
    echo "File $1 could not be found!"
fi

if [ ! -d $2 ]; then
    echo "Path $2 could not be found!"
fi

echo Current doxygen-action directory: `pwd`
cd $2
doxygen $1
