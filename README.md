# Doxygen Docker Action
This [GitHub Action](https://github.com/features/actions) will build [doxygen](http://doxygen.nl/) docs from the specified doxyfile.

Use with an action such as [actions-gh-pages](https://github.com/peaceiris/actions-gh-pages) to deploy to your project's GitHub pages site!

**NOTE:** If you are using dot/graphviz in your doxygen config to generate diagrams the only fonts installed, and hence can be used are those in the [GNU FreeFont](https://www.gnu.org/software/freefont/) package (FreeSans, FreeMono and FreeSerif).

## Inputs
### 'working-directory'
**Required** Path of the working directory to change to before running doxygen. Default: `.`
### 'doxyfile-path'
**Required** Path of the Doxyfile relative to the working directory. Default: `./Doxyfile`.
### 'enable-latex'
**Optional** Flag to enable `make`-ing of the LaTeX part of the doxygen output. Default: `false`.
### 'fail-on-warnings'
**Not Required** Make this action fail if doxygen produces warnings. Will print the warnings if this value is set to `TRUE`. Default: `FALSE`. 
### 'warnings-filter'
**Not Required** Enables a filter for the warnings relevant to fail-on-warnings. Matching lines will be filtered out using grep. If this value is empty, no filter is applied. Default: empty string.

## Example usage (no LaTeX)
```yaml
uses: mattnotmitt/doxygen-action@v1
with:
    working-directory: 'submodule/'
    doxyfile-path: 'docs/Doxygen'
    fail-on-warnings: 'TRUE'
    warnings-filter: 'stupid-warning-I-want-to-ignore'
```

## Example usage (with LaTeX)
```yaml
uses: mattnotmitt/doxygen-action@v1
with:
    working-directory: 'submodule/'
    doxyfile-path: 'docs/Doxygen'
    enable-latex: true
    fail-on-warnings: 'TRUE'
    warnings-filter: 'stupid-warning-I-want-to-ignore'
```
