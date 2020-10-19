%%
%% This is file `mikoslides.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% mikoslides.dtx  (with options: `cls')
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{mikoslides}[2020/10/17 v1.3 MiKo slides Class]
\RequirePackage{stex-base}
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\SetupKeyvalOptions{family=mks@cls,prefix=mks@cls@}
\DeclareStringOption[article]{class}
\AddToKeyvalOption*{class}{\PassOptionsToClass{class=\mks@cls@class}{omdoc}
  \ifdefstring{\mks@cls@class}{book}{\PassOptionsToPackage{defaulttopsect=part}{mikoslides}}{}
  \ifdefstring{\mks@cls@class}{report}{\PassOptionsToPackage{defaulttopsect=part}{mikoslides}}}{}
\DeclareBoolOption{notes}
\DeclareComplementaryOption{slides}{notes}
\DeclareDefaultOption{%
  \PassOptionsToClass{\CurrentOption}{omdoc}
  \PassOptionsToClass{\CurrentOption}{beamer}
  \PassOptionsToPackage{\CurrentOption}{mikoslides}}
\ProcessKeyvalOptions{mks@cls}
\ifmks@cls@notes
  \LoadClass{omdoc}
\else
  \LoadClass[10pt,notheorems,xcolor={dvipsnames,svgnames}]{beamer}
  \newcounter{Item}
  \newcounter{paragraph}
  \newcounter{subparagraph}
  \newcounter{Hfootnote}
\fi
\RequirePackage{mikoslides}
\endinput
%%
%% End of file `mikoslides.cls'.
