# sTeX-tests: Systematic Tests for the sTeX Distribution

This repository  contains tests for the
[sTeX distribution](https://github.com/sLaTeX/sTeX)

They will be integrated into the [sTeX](https://github.com/sLaTeX/sTeX) and
[LaTeXML-Plugin-sTeX](https://github.com/sLaTeX/LaTeXML-Plugin-sTeX] repositories via `git
subrepo`. 

There are two test targets: 
* `omdoc` for  OMDoc generated and
* `html` for sTeX annotations in HTML (later).

## Manifest
* `omdoc`: Files for the `omdoc` target. This is organized by
[sTeX package/class](https://github.com/sLaTeX/sTeX/tree/master/sty/): one directory for
each that contains various `*.tex` files that can be run via the `Makefile` in the
directory.
* `make`: Makefile fragments for automation


