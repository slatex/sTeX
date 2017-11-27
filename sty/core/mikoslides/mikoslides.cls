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
\else
  \LoadClass[10pt,notheorems]{beamer}
  \newcounter{Item}
  \newcounter{paragraph}
  \newcounter{subparagraph}
  \newcounter{Hfootnote}
\fi
\RequirePackage{mikoslides}
\endinput
%%
%% End of file `mikoslides.cls'.
