%%
%% This is file `mikoslides.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% mikoslides.dtx  (with options: `cls')
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{mikoslides}[2015/10/04 v1.0 Jacobs slides Class]
\newif\ifnotes\notesfalse
\DeclareOption{notes}{\notestrue}
\DeclareOption{slides}{\notesfalse}
\newif\ifsectocframes\sectocframesfalse
\DeclareOption{sectocframes}{\sectocframestrue}
\newif\ifframeimages\frameimagesfalse
\DeclareOption{frameimages}{\frameimagestrue}
\newif\if@part\@partfalse
\DeclareOption{report}{\@parttrue\PassOptionsToClass{\CurrentOption}{omdoc}}
\DeclareOption{book}{\@parttrue\PassOptionsToClass{\CurrentOption}{omdoc}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{omdoc}
                \PassOptionsToClass{\CurrentOption}{beamer}}
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{mikoslides}}
\ProcessOptions
\ifnotes
  \LoadClass{omdoc}
  \RequirePackage{a4wide}
  \RequirePackage{marginnote}
  \RequirePackage{mdframed}
  \RequirePackage[notheorems,noamsthm,noxcolor]{beamerarticle}
\else
  \LoadClass[notheorems,noamsthm,10pt]{beamer}
  \newcounter{Item}
  \newcounter{paragraph}
  \newcounter{subparagraph}
  \newcounter{Hfootnote}
  \usetheme{Jacobs}
\fi
\RequirePackage{mikoslides}

\ifsectocframes%
  \if@part%
    \newcounter{mpart}%
    \newcounter{mchapter}%
    \newcounter{msection}[mchapter]%
  \else%
    \newcounter{msection}%
  \fi%
  \newcounter{msubsection}[msection]%
  \newcounter{msubsubsection}[msubsection]%
  \newcounter{msubsubsubsection}[msubsubsection]%
  \ifnotes\else% only in slides
    \renewcommand\at@begin@omgroup[3][]{%
      \begin{frame}%
      \vfill\Large\centering%
      \red{%
       \ifcase\section@level\or%
          \stepcounter{mpart}Part \Roman{mpart}\or%
          \stepcounter{mchapter}Chapter \arabic{mchapter}\or
          \stepcounter{msection}\if@part\arabic{mchapter}.\fi\arabic{msection}\or
          \stepcounter{msubsection}\if@part\arabic{mchapter}.\fi\arabic{msection}.\arabic{msubsection}\or
          \stepcounter{msubsubsection}\if@part\arabic{mchapter}.\fi\arabic{msection}.\arabic{msubsection}.\arabic{msubsubsection}.\or
          \stepcounter{msubsubsubsection}\if@part\arabic{mchapter}.\fi\arabic{msection}.\arabic{msubsection}.\arabic{msubsubsection}.\arabic{msubsubsubsection}%
        \fi% end ifcase
        \quad #3%
      }%
      \vfill%
      \end{frame}%
    }%
  \fi% ifnotes
\fi% ifsectocframes
\endinput
%%
%% End of file `mikoslides.cls'.
