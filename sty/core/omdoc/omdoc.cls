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
\AddToKeyvalOption*{class}{\PassOptionsToPackage{class=\omdoc@cls@class}{omdoc}}
\DeclareVoidOption{report}{\def\omdoc@cls@class{report}%
\ClassWarning{omdoc}{the option 'report' is deprecated, use 'class=report', instead}}
\DeclareVoidOption{book}{\def\omdoc@cls@class{book}%
\ClassWarning{omdoc}{the option 'part' is deprecated, use 'class=book', instead}}
\DeclareVoidOption{bookpart}{\def\omdoc@cls@class{book}%
\PassOptionsToPackage{topsect=chapter}{omdoc}%
\ClassWarning{omdoc}{the option 'bookpart' is deprecated, use 'class=book,topsect=chapter', instead}}
\RequirePackage{etoolbox}
\def\@omdoc@cls@docopt{}
\DeclareDefaultOption{%
\ifx\@omdoc@cls@docopt\@empty%
\xdef\@omdoc@cls@docopt{\CurrentOption}%
\else\xappto\@omdoc@cls@docopt{,\CurrentOption}%
\fi}%
\PassOptionsToPackage{\CurrentOption}{omdoc}
\PassOptionsToPackage{\CurrentOption}{stex}
\ProcessKeyvalOptions{omdoc@cls}
\LoadClass[\@omdoc@cls@docopt]{\omdoc@cls@class}
\RequirePackage{etoolbox}
\RequirePackage{omdoc}
\RequirePackage{stex}
\srefaddidkey{document}
\newcommand\documentkeys[1]{\metasetkeys{document}{#1}}
\let\orig@document=\document
\srefaddidkey{document}
\renewcommand{\document}[1][]{\metasetkeys{document}{#1}\orig@document}
\ifcsdef{frontmatter}% to redefine if necessary
{\cslet{orig@frontmatter}{\frontmatter}\cslet{frontmatter}{\relax}}
{\cslet{orig@frontmatter}{\clearpage\pagenumbering{roman}}}
\newenvironment{frontmatter}
{\@frontmattertrue\orig@frontmatter}
{\@frontmatterfalse%
\ifcsdef{mainmatter}{\mainmatter}{\clearpage\pagenumbering{arabic}}}
\ifcsdef{backmatter}% to redefine if necessary
{\cslet{orig@backmatter}{\backmatter}\cslet{backmatter}{\relax}}
{\cslet{orig@backmatter}{\clearpage\pagenumbering{roman}}}
\newenvironment{backmatter}{\orig@backmatter\@backmattertrue}{\@backmatterfalse}
\endinput
%%
%% End of file `omdoc.cls'.
