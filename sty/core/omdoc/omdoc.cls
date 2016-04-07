%%
%% This is file `omdoc.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% omdoc.dtx  (with options: `cls')
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{omdoc}[2016/04/07 v1.2 OMDoc Documents]
\def\omdoc@class{article}
\DeclareOption{report}{\def\omdoc@class{report}%
  \PassOptionsToPackage{\CurrentOption}{omdoc}
  \PassOptionsToPackage{\CurrentOption}{stex}}
\newif\ifclass@book\class@bookfalse
\DeclareOption{book}{\def\omdoc@class{book}\class@booktrue%
  \PassOptionsToPackage{\CurrentOption}{omdoc}
  \PassOptionsToPackage{\CurrentOption}{stex}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\omdoc@class}
                           \PassOptionsToPackage{\CurrentOption}{omdoc}
                           \PassOptionsToPackage{\CurrentOption}{stex}}
\ProcessOptions
\LoadClass{\omdoc@class}
\RequirePackage{etoolbox}
\RequirePackage{omdoc}
\RequirePackage{stex}
\srefaddidkey{document}
\newcommand\documentkeys[1]{\metasetkeys{document}{#1}}
\let\orig@document=\document
\srefaddidkey{document}
\renewcommand{\document}[1][]{\metasetkeys{document}{#1}\orig@document}
\ifclass@book
\renewenvironment{frontmatter}
{\@frontmattertrue\cleardoublepage\@mainmatterfalse\pagenumbering{roman}}
{\@frontmatterfalse\setcounter{page}{1}\pagenumbering{arabic}}
\else
\newenvironment{frontmatter}
{\@frontmattertrue\pagenumbering{roman}}
{\@frontmatterfalse\setcounter{page}{1}\pagenumbering{arabic}}
\fi
\ifclass@book
\renewenvironment{backmatter}
{\cleardoublepage\@mainmatterfalse\@backmattertrue}
{\@backmatterfalse}
\else
\newenvironment{backmatter}{\@backmattertrue}{\@backmatterfalse}
\fi
\endinput
%%
%% End of file `omdoc.cls'.
