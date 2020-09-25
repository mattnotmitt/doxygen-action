#!/bin/sh

# execute doxygen
# $1 is the path to the Doxyfile
# $2 is the directory where doxygen should be executed
# $3 is a boolean: true -> enable latex generation, false -> skip latex generation

if [ ! -d $2 ]; then
    echo "Path $2 could not be found!"
fi
cd $2

if [ ! -f $1 ]; then
    echo "File $1 could not be found!"
fi

# install packages; add latex-related packages only if enabled
PACKAGES="doxygen graphviz ttf-freefont"
if [ ! -z $3 ] ; then
  if [ "$3" = true ] ; then
    PACKAGES="$PACKAGES perl build-base texlive-full biblatex"
  fi
fi
apk add $PACKAGES

# run "regular" doxygen
doxygen $1

# if enabled, make latex pdf output
if [ ! -z $3 ] ; then
  if [ "$3" = true ] ; then
    cd $2/docs/latex
    make
  fi
fi
