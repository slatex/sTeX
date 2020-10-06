sTeX: An Infrastructure for Semantic Preloading of LaTeX Documents
====
![CI Status](https://github.com/slatex/sTeX/workflows/CI/badge.svg)

This repository contains the sTeX package collection, a version of TeX/LaTeX that allows
to markup TeX/LaTeX documents semantically without leaving the document format,
essentially turning it into a document format for mathematical knowledge management (MKM).

## Copyright & License
Copyright (c) 2019 Michael Kohlhase
The package is distributed under the terms of the LaTeX Project Public License (LPPL)

## Documentation
See the
[documentation of the sTeX package](https://github.com/slatex/sTeX/blob/master/sty/stex/stex.pdf)
for details.

## Setup

The GIT version can just be cloned in a directory `<sTeXDIR>` of your choosing. 
```
cd <sTeXDIR>
git clone https://github.com/slatex/sTeX.git
```
Then update your  `TEXINPUTS` environment variable, e.g. by placing the following line in your `.bashrc`:
```
export TEXINPUTS="$(TEXINPUTS):<sTeXDIR>//:
```
For a LaTeX IDE, update the directory path where `pdflatex` looks for paths. 

It is usually a good idea to enlarge the internal memory allocation of the TEX/LATEX executables. This can be done by adding the following configurations in `texmf.cnf` (or changing them, if they already exist). 
```
max_in_open = 50        % simultaneous input files and error insertions, 
param_size = 20000      % simultaneous macro parameters, also applies to MP
nest_size = 1000        % simultaneous semantic levels (e.g., groups)
stack_size = 10000      % simultaneous input sources
main_memory = 12000000
```
Note that you will probably need `sudo` to do this. After that, you have to run the command 
```
sudo fmtutil-sys --all
```

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
  subrepo`; run `make -B test` at top level to test; run `git subrepo pull test` to
  update; and run `git subrepo push test` to contribute tests back upstream. 
