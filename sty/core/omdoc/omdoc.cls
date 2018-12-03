%%
%% This is file `omdoc.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% omdoc.dtx  (with options: `cls')
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{omdoc}[2018/12/03 v1.3 OMDoc Documents]
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=omdoc@cls,prefix=omdoc@cls@}
\DeclareStringOption[article]{class}
\DeclareBoolOption{matter}
\RequirePackage{etoolbox}
\DeclareVoidOption{report}{\def\omdoc@cls@class{report}%
\ClassWarning{omdoc}{the option 'report' is deprecated, use 'class=report', instead}}
\DeclareVoidOption{book}{\def\omdoc@cls@class{book}\omdoc@cls@mattertrue%
\ClassWarning{omdoc}{the option 'bookpart' is deprecated, use 'class=book,matter', instead}}
\DeclareVoidOption{bookpart}{\def\omdoc@cls@class{book}\omdoc@cls@mattertrue%
\PassOptionToPackage{topsect=chapter}{omdoc}%
\ClassWarning{omdoc}{the option 'bookpart' is deprecated, use 'class=book,matter,topsect=chapter', instead}}
\def\@omdoc@cls@docopt{}
\DeclareDefaultOption{%
\ifx\@omdoc@cls@docopt\@empty%
\xdef\@omdoc@cls@docopt{\CurrentOption}%
\else\xappto\@omdoc@cls@docopt{,\CurrentOption}%
\fi%
\PassOptionsToPackage{\CurrentOption}{omdoc}
\PassOptionsToPackage{\CurrentOption}{stex}}
\ProcessKeyvalOptions{omdoc@cls}
\LoadClass[\@omdoc@cls@docopt]{\omdoc@cls@class}
\RequirePackage{omdoc}
\RequirePackage{stex}
\srefaddidkey{document}
\newcommand\documentkeys[1]{\metasetkeys{document}{#1}}
\let\orig@document=\document
\srefaddidkey{document}
\renewcommand{\document}[1][]{\metasetkeys{document}{#1}\orig@document}
\ifomdoc@cls@matter
\renewenvironment{frontmatter}
{\@frontmattertrue\cleardoublepage\@mainmatterfalse\pagenumbering{roman}}
{\@frontmatterfalse\setcounter{page}{1}\pagenumbering{arabic}}
\else
\newenvironment{frontmatter}
{\@frontmattertrue\pagenumbering{roman}}
{\@frontmatterfalse\setcounter{page}{1}\pagenumbering{arabic}}
\fi
\ifomdoc@cls@matter
\renewenvironment{backmatter}
{\cleardoublepage\@mainmatterfalse\@backmattertrue}
{\@backmatterfalse}
\else
\newenvironment{backmatter}{\@backmattertrue}{\@backmatterfalse}
\fi
\endinput
%%
%% End of file `omdoc.cls'.
