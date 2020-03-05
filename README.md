# Doxygen Docker Action
This [GitHub Action](https://github.com/features/actions) will build [doxygen](http://doxygen.nl/) docs according to a specified Doxyfile - if omitted will search in the root directory of the repo.

**NOTE:** If you are using dot/graphviz in your doxygen config to generate diagrams the only fonts installed, and hence can be used are those in the [GNU FreeFont](https://www.gnu.org/software/freefont/) package (FreeSans, FreeMono and FreeSerif).


## Inputs
### 'doxyfile-path'
**Required** Path of the Doxyfile relative to the repository root. By default `./Doxyfile'.

## Example usage
```yaml
uses: mattnotmitt/doxygen-action@v0.1
with:
    doxyfile-path: 'docs/Doxygen'
```