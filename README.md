sTeX: An Infrastructure for Semantic Preloading of LaTeX Documents
====
![CI Status](https://github.com/slatex/sTeX/workflows/CI/badge.svg)

This repository contains the sTeX package collection, a version of TeX/LaTeX that allows
to markup TeX/LaTeX documents semantically without leaving the document format. 

Running `pdflatex` over sTeX-annotated documents formats them into normal-looking PDF. But
sTeX also comes with a [conversion pipeline](https://github.com/slatex/RusTeX) into 
semantically annotated HTML5, which can host semantic added-value services that make the
documents active (i.e. interactive and user-adaptive) and essentially turning LaTeX into a
document format for (mathematical) knowledge management (MKM).

## Copyright & License

Copyright (c) 2022 Michael Kohlhase
The package is distributed under the terms of the LaTeX Project Public License (LPPL)

## Maintainers
[Michael Kohlhase](https://kwarc.info/kohlhase), [Dennis Müller](https://kwarc.info/people/dmueller), FAU Erlangen-Nürnberg. 

## Documentation
The [sTeX manual ](https://github.com/slatex/sTeX/blob/main/doc/stex-manual.pdf) gives a
general introduction and motivation. The 
[sTeX package documentation](https://github.com/slatex/sTeX/blob/main/doc/stex-doc.pdf)
gives the details of the implementation. A complete list of sTeX-related publications can
be found [here](https://kwarc.github.io/bibs/sTeX/). 

## sTeX Corpus & Best Practices

sTeX comes with a large corpus of pre-annotated materials that act as evaluation grounds
and regression tests for the sTeX functionality and best practices that are publicly
available. 
* [SMGLoM](https://gl.mathhub.info/smglom), the Semantic, Multilingual Glossary of
  Mathematics (and similar disciplines). SMGloM provides a large set of definitions and
  well-designed semantic macros for core mathematical (and computation) concepts and
  objects. This resource greatly facilitates "getting off the ground" in semantic
  annotation.
* [courses](https://gl.mathhub.info/courses) a set of semantically annotated courses in
  computer science and (symbolic) AI (ca. 7000 pages of slides and notes). Ca. 5000
  problem/solutions and old exams are available publicly (more exist in private
  repositories). 
* [Papers](https://gl.mathhub.info/Papers) a set of semantically annotated research papers 
  about the work in the [KWARC group at FAU](https://kwarc.info). 
* [talks](https://gl.mathhub.info/talks) a set of semantically annotated presentations
  about the work in the [KWARC group at FAU](https://kwarc.info). 
* [sTeX3 Labs](https://gl.mathhub.info/sTeX) a set of experimental re-formalizations of
  (mostly) [SMGLoM](https://gl.mathhub.info/smglom) material to fully take advantage of
  the sTeX3 functionality and the
  [rusTeX](https://github.com/slatex/RusTeX)/[MMT](https://uniformal.github.io) pipeline
  and knowledge management facilities. 

All of these are hosted on [MathHub](https://mathhub.info), a portal for the
management of active mathematical documents and flexiformal mathematics. The organization
of the material into "mathematical archives" (GIT repositories with a particular
standardized structure on [a GitLab repository management server](https://gl.mathhub.info)
greatly enhances modularization and the provision of added value services.

## Application: The ALeA System

sTeX is the main content representation format used in the [ALeA
System](https://alea.education), and adaptive learning assistant, which uses the semantic
annotations for adaptive course materials and interactive learning interventions.

## Setup

The GIT version can just be cloned in a directory `<sTeXDIR>` of your choosing. 
```
cd <sTeXDIR>
git clone https://github.com/slatex/sTeX.git
```
Then update your  `TEXINPUTS` environment variable, e.g. by placing the following line in your `.bashrc`:
```
export TEXINPUTS="$(TEXINPUTS):<sTeXDIR>//:"
```

Similarly, set your `MATHHUB` environment variable to where you intend to keep your sTeX
archives. For details, see the documentation linked above. For a LaTeX IDE, update the directory path where `pdflatex` looks for paths. 

For larger documents it may (rarely) be necessary to enlarge the internal memory allocation of the TEX/LATEX executables. This can be done by adding the following configurations in `texmf.cnf` (or changing them, if they already exist). 
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

<!--  LocalWords:  LPPL SMGLoM sTeXDIR cd TEXINPUTS bashrc texmf cnf param sudo fmtutil -->
<!--  LocalWords:  sys CTAN dtx tex bibTeX -->
