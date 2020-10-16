#!/bin/sh

# execute doxygen
# $1 is the path to the Doxyfile
# $2 is the directory where doxygen should be executed
# $3 is a boolean: true -> enable latex generation, false -> skip latex generation

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
if [ ! -z $3 ] ; then
  BUILD_LATEX=$3 && $(grep -q GENERATE_LATEX\\s\*=\\s\*YES $1)
  LATEX_DIR="$(sed -n -e 's/^OUTPUT_DIRECTORY\s*=\s*//p' Doxyfile)/$(sed -n -e 's/^LATEX_OUTPUT\s*=\s*//p' Doxyfile)"
else
  BUILD_LATEX=0
fi

PACKAGES="doxygen graphviz ttf-freefont"
if [ "$BUILD_LATEX" = true ] ; then
  PACKAGES="$PACKAGES perl build-base texlive-full biblatex"
fi
apk add $PACKAGES


# Tests if the third argument is either 'TRUE' or 'FALSE'. Produces warning if neither is set.
if [ "$4" = "TRUE" ]; then
    echo "Failing on warnings is enabled."
    fail_on_warnings=true
elif [ "$4" = "FALSE" ]; then
    echo "Failing on warnings disabled."
    fail_on_warnings=false
else
    echo "Unknown value for fail-on-warnings. Should be either 'FALSE' or 'TRUE'."
    exit 1
fi

if [ "$fail_on_warnings" = true ]; then
    doxygen $1 2> warnings.txt

    # if $5 is non-empty, apply filter.
    if [ ! -z "$5" ]; then
      grep "$5" warnings.txt > filtered-out-warnings.txt
      filtered_amount=$(cat filtered-out-warnings.txt | wc -l)
      printf "Total amount of filtered-out doxygen errors and warnings: '%d'\n"  "$filtered_amount"
      echo "Filtered-out warnings:"
      cat filtered-out-warnings.txt
      grep -v "$5" warnings.txt > warnings-filtered.txt
      mv warnings-filtered.txt warnings.txt
    else
      echo "No filter specified, not filtering any warnings."
    fi
    problems_amount=$(cat warnings.txt | wc -l)
    printf "Total amount of doxygen errors and warnings: '%d'\n"  "$problems_amount"
    if [ $problems_amount -ne 0 ] ; then
        echo "Building doxygen documentation: FAILURE. With the following warnings:"
        cat warnings.txt
        exit 1
    else
        echo "Building doxygen documentation: SUCCESS."
    fi
else
  doxygen $1
fi


# if enabled, make latex pdf output
if [ "$BUILD_LATEX" = true ] ; then
  cd $LATEX_DIR
  make
fi
