%%
%% This is file `omdoc.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% omdoc.dtx  (with options: `cls')
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{omdoc}[2019/03/20 v1.3 OMDoc Documents]
\RequirePackage{etoolbox}
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
\RequirePackage{omdoc}
\RequirePackage{stex}
\srefaddidkey{document}
\newcommand\documentkeys[1]{\metasetkeys{document}{#1}}
\let\orig@document=\document
\renewcommand{\document}[1][]{\metasetkeys{document}{#1}\orig@document}
\ifcsdef{frontmatter}% to redefine if necessary
  {\cslet{orig@frontmatter}{\frontmatter}\cslet{frontmatter}{\relax}}
  {\cslet{orig@frontmatter}{\clearpage\@mainmatterfalse\pagenumbering{roman}}}
\ifcsdef{backmatter}% to redefine if necessary
  {\cslet{orig@backmatter}{\backmatter}\cslet{backmatter}{\relax}}
  {\cslet{orig@backmatter}{\clearpage\@mainmatterfalse\pagenumbering{roman}}}
\newenvironment{frontmatter}
{\orig@frontmatter}
{\ifcsdef{mainmatter}{}{\clearpage\@mainmattertrue\pagenumbering{arabic}}}
\newenvironment{backmatter}
{\orig@backmatter}
{\ifcsdef{mainmatter}{}{\clearpage\@mainmattertrue\pagenumbering{arabic}}}
\pagenumbering{arabic}
\endinput
%%
%% End of file `omdoc.cls'.
