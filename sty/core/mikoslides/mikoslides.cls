%%
%% This is file `mikoslides.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% mikoslides.dtx  (with options: `cls')
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{mikoslides}[2016/04/07 v1.1 MiKo slides Class]
\newif\ifnotes\notesfalse
\DeclareOption{notes}{\notestrue\PassOptionsToPackage{\CurrentOption}{mikoslides}}
\DeclareOption{slides}{\notesfalse\PassOptionsToPackage{\CurrentOption}{mikoslides}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{omdoc}
                           \PassOptionsToClass{\CurrentOption}{beamer}
                           \PassOptionsToPackage{\CurrentOption}{mikoslides}}
\ProcessOptions
\ifnotes
  \LoadClass{omdoc}
  \RequirePackage{a4wide}
  \RequirePackage{marginnote}
  \RequirePackage{mdframed}
  \RequirePackage[notheorems,noamsthm,noxcolor]{beamerarticle}
  \RequirePackage[bookmarks,bookmarksopen,bookmarksnumbered,breaklinks,
       linkcolor=black,citecolor=black,urlcolor=cyan,filecolor=cyan,colorlinks]{hyperref}
\else
  \LoadClass[notheorems,noamsthm,10pt]{beamer}
  \newcounter{Item}
  \newcounter{paragraph}
  \newcounter{subparagraph}
  \newcounter{Hfootnote}
\fi
\ifnotes
\renewcommand\usetheme[2][]{\usepackage[#1]{beamernotestheme#2}}
\fi
\RequirePackage{mikoslides}
\endinput
%%
%% End of file `mikoslides.cls'.
