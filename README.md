# Doxygen Docker Action
This [GitHub Action](https://github.com/features/actions) will build [doxygen](http://doxygen.nl/) docs according to a specified Doxyfile - if omitted will search in the root directory of the repo.

Use with an action such as [actions-gh-pages](https://github.com/peaceiris/actions-gh-pages) to deploy to your project's GitHub pages site!

**NOTE:** If you are using dot/graphviz in your doxygen config to generate diagrams the only fonts installed, and hence can be used are those in the [GNU FreeFont](https://www.gnu.org/software/freefont/) package (FreeSans, FreeMono and FreeSerif).

## Inputs
### 'doxyfile-path'
**Required** Path of the Doxyfile relative to the repository root. Default: `./Doxyfile`.

## Example usage
```yaml
uses: mattnotmitt/doxygen-action@v1
with:
    doxyfile-path: 'docs/Doxygen'
```