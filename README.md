sTeX: An Infrastructure for Semantic Preloading of LaTeX Documents
====
![CI Status](https://github.com/slatex/sTeX/workflows/CI/badge.svg)

This repository contains the sTeX package collection, a version of TeX/LaTeX that allows
to markup TeX/LaTeX documents semantically without leaving the document format,
essentially turning it into a document format for mathematical knowledge management (MKM).

## Copyright & License

Copyright (c) 2022 Michael Kohlhase
The package is distributed under the terms of the LaTeX Project Public License (LPPL)

## Maintainers
Michael Kohlhase, Dennis Müller, FAU Erlangen-Nürnberg. 

## Documentation
See the
[documentation of the sTeX package](https://github.com/slatex/sTeX/blob/main/doc/stex-doc.pdf)
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

Similarly, set your `MATHHUB` environment variable to where you intend to keep your sTeX archives. For details, see the documentation linked above.

For a LaTeX IDE, update the directory path where `pdflatex` looks for paths. 
For larger documents it may be necessary to enlarge the internal memory allocation of the TEX/LATEX executables. This can be done by adding the following configurations in `texmf.cnf` (or changing them, if they already exist). 
```
param_size = 20000      % simultaneous macro parameters, also applies to MP
nest_size = 1000        % simultaneous semantic levels (e.g., groups)
stack_size = 10000      % simultaneous input sources
main_memory = 12000000
```
Note that you will probably need `sudo` to do this. After that, you have to run the command 
```
sudo fmtutil-sys --all
```

## Manifest
The sTeX distribution contains the following directories (conformant with the CTAN organization
* `source`: The [Documented LaTeX sources (dtx files)](https://texfaq.org/FAQ-dtx)
* `tex`: packages and classes of the sTeX distribution
* `lib`: bibTeX bibliography
* `doc`: the sTeX manual  and further documentation
