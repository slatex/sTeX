sTeX: An Infrastructure for Semantic Preloading of LaTeX Documents
====
[![Build Status](https://travis-ci.org/sLaTeX/sTeX.svg?branch=master)](https://travis-ci.org/sLaTeX/sTeX)

This repository contains the sTeX package collection, a version of TeX/LaTeX that allows
to markup TeX/LaTeX documents semantically without leaving the document format,
essentially turning it into a document format for mathematical knowledge management (MKM).

Copyright (c) 2019 Michael Kohlhase
The package is distributed under the terms of the LaTeX Project Public License (LPPL)

## Documentation
See the
[documentation of the sTeX package](https://github.com/slatex/sTeX/blob/master/sty/stex/stex.pdf)
for details.

## OMDoc/RichHTML Transformation 

sTeX documents can be transformed to [OMDoc](http://omdoc.org) via the
[sTeX Plugin](https://github.com/sLaTeX/LaTeXML-Plugin-sTeX/) for
[LaTeXML](https://github.com/brucemiller/LaTeXML) available at
https://github.com/sLaTeX/LaTeXML-Plugin-sTeX/.

## Manifest
The sTeX distribution contains the following directories
* `sty`: The packages and classes of the sTeX distribution
* `lib`: bibTeX bibliography and Makefile inputs for the package/class generation and documentation
* `bin`: a couple of utilities that make your life easier
* `doc`: a space for documentation, currently only blue notes (ideas for the future)
* `example`: a worked example of an sTeX paper.   
* `test`: the [sTeX test suite](https://github.com/sLaTeX/stex-tests) imported via `git
  subrepo`; run `make test` at test level to test.
