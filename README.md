# Doxygen Docker Action

This [GitHub Action](https://github.com/features/actions) will build [doxygen](http://doxygen.nl/) docs from the specified doxyfile.

Use with an action such as [actions-gh-pages](https://github.com/peaceiris/actions-gh-pages) to deploy to your project's GitHub pages site!

**NOTE:** If you are using dot/graphviz in your doxygen config to generate diagrams the only fonts installed, and hence can be used are those in the [GNU FreeFont](https://www.gnu.org/software/freefont/) package (FreeSans, FreeMono and FreeSerif) or in any package listed in `additional-packages`.

## Inputs

### 'working-directory'

**Optional** Path of the working directory to change to before running doxygen. Default: `.`

### 'doxyfile-path'

**Optional** Path of the Doxyfile relative to the working directory. Default: `./Doxyfile`.

### 'enable-latex'

**Optional** Flag to enable `make`-ing of the LaTeX part of the doxygen output. Default: `false`.

### 'additional-packages'

**Optional** Additional [Alpine packages](https://pkgs.alpinelinux.org/packages) to install in the environment (i.e. font packages)

## Example usage with additional font package
```yaml
uses: mattnotmitt/doxygen-action@v1
with:
    additional-packages: font-fira-code
```

## Example usage with set working dir and doxyfile path (no LaTeX)

```yaml
uses: mattnotmitt/doxygen-action@v1
with:
    working-directory: 'submodule/'
    doxyfile-path: 'docs/Doxygen'
```

## Example usage (with LaTeX)

```yaml
uses: mattnotmitt/doxygen-action@v1
with:
    working-directory: 'submodule/'
    doxyfile-path: 'docs/Doxygen'
    enable-latex: true
```
