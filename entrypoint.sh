#!/bin/sh -xe

# execute doxygen
# $1 is the path to the Doxyfile
# $2 is the directory where doxygen should be executed
# $3 is a boolean: true -> enable latex generation, false -> skip latex generation
# $4 is a string with extra alpine packages to be installed (i.e. font-fira-code)

if [ ! -d $2 ]; then
  echo "Path $2 could not be found!"
  exit 1
fi
cd $2

if [ ! -f $1 ]; then
  echo "File $1 could not be found!"
  exit 1
fi

# install packages; add latex-related packages only if enabled
if [ ! -z $3 ] && $3; then
  # Only enable BUILD_LATEX if specified in doxyfile
  grep -q GENERATE_LATEX\\s\*=\\s\*YES $1 && BUILD_LATEX=true || BUILD_LATEX=false
  LATEX_DIR="./$(sed -n -e 's/^OUTPUT_DIRECTORY\s*=\s*//p' $1)/$(sed -n -e 's/^LATEX_OUTPUT\s*=\s*//p' $1)"
else
  BUILD_LATEX=0
fi

PACKAGES="doxygen graphviz ttf-freefont $4"
if [ "$BUILD_LATEX" = true ] ; then
  PACKAGES="$PACKAGES perl build-base texlive-full biblatex ghostscript"
fi
apk add $PACKAGES

echo "::notice::You're on the bleeding edge of doxygen-action. To pin this version use: mattnotmitt/doxygen-action@$(doxygen --version)"

# run "regular" doxygen
doxygen $1

# if enabled, make latex pdf output
if [ "$BUILD_LATEX" = true ] ; then
  cd $LATEX_DIR
  make
fi
