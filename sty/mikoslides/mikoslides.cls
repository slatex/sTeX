%%
%% This is file `mikoslides.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% mikoslides.dtx  (with options: `cls')
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{mikoslides}[2014/01/07 v1.0 Jacobs slides]
\DeclareOption{showmeta}{\PassOptionsToPackage{\CurrentOption}{metakeys}}
\newif\ifnotes\notesfalse
\newif\ifsectocframes\sectocframesfalse
\newif\ifframeimages\frameimagesfalse
\newif\ifproblems\problemstrue
\DeclareOption{notes}{\notestrue}
\DeclareOption{slides}{\notesfalse}
\DeclareOption{noproblems}{\problemsfalse}
\DeclareOption{sectocframes}{\sectocframestrue}
\DeclareOption{frameimages}{\frameimagestrue}
\newif\if@part\@partfalse
\DeclareOption{report}{\@parttrue\PassOptionsToClass{\CurrentOption}{omdoc}}
\DeclareOption{book}{\@parttrue\PassOptionsToClass{\CurrentOption}{omdoc}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{omdoc}
                \PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions
\ifnotes
\LoadClass{omdoc}
\RequirePackage{a4wide}
\RequirePackage{marginnote}
\RequirePackage{mdframed}
\RequirePackage[notheorems,noamsthm,noxcolor]{beamerarticle}
\else
\if@part% report or book class
\renewenvironment{frontmatter}{}{}
\fi
\LoadClass[notheorems,noamsthm,10pt]{beamer}
\newcounter{Item}
\newcounter{paragraph}
\newcounter{subparagraph}
\newcounter{Hfootnote}
\usetheme{Jacobs}
\fi
\RequirePackage{tikzinput}
\RequirePackage{stex}
\RequirePackage{latexml}
\RequirePackage{amssymb}
\RequirePackage{tikz}
\usepgflibrary{shapes}
\usetikzlibrary{arrows}
\usetikzlibrary{positioning}
\usetikzlibrary{tikzmark}%experimental/beta but very useful
\usetikzlibrary{fit}
\RequirePackage{url}
\RequirePackage{amsmath}
\RequirePackage{comment}
\RequirePackage{standalone}
\RequirePackage{textcomp}
\newcounter{slide}
\newlength{\slidewidth}\setlength{\slidewidth}{12.3cm}
\newlength{\slideheight}\setlength{\slideheight}{9cm}
\ifnotes\renewenvironment{note}{\ignorespaces}{}\else\excludecomment{note}\fi
\ifnotes
\newlength{\slideframewidth}\setlength{\slideframewidth}{1.5pt}
\addmetakey{frame}{label}
\addmetakey[yes]{frame}{allowframebreaks}
\addmetakey{frame}{allowdisplaybreaks}
\addmetakey[yes]{frame}{fragile}
\addmetakey[yes]{frame}{shrink}
\addmetakey[yes]{frame}{squeeze}
\renewenvironment{frame}[1][]%
{\metasetkeys{frame}{#1}%
\stepcounter{slide}\def\@currentlabel{\theslide}%
\ifx\frame@label\@empty\else\label{\frame@label}\fi
\def\itemize@level{outer}%
\def\itemize@outer{outer}%
\def\itemize@inner{inner}%
\renewcommand\newpage{}%
\renewcommand\metakeys@show@keys[2]{\marginnote{{\scriptsize ##2}}}%
\renewenvironment{itemize}%
{\ifx\itemize@level\itemize@outer\def\itemize@label{$\rhd$}\fi%
 \ifx\itemize@level\itemize@inner\def\itemize@label{$\scriptstyle\rhd$}\fi%
  \begin{list}%
    {\itemize@label}%
    {\setlength{\labelsep}{.3em}\setlength{\labelwidth}{.5em}\setlength{\leftmargin}{1.5em}}%
  \edef\itemize@level{\itemize@inner}}%
{\end{list}}
\begin{mdframed}[linewidth=\slideframewidth,skipabove=1ex,skipbelow=1ex,
userdefinedwidth=\slidewidth,align=center]\sf}
{\medskip\miko@slidelabel\end{mdframed}}
\renewcommand{\frametitle}[1]{{\Large\bf\sf\color{blue}{#1}}\medskip}
\fi
\newcommand\frameimage[2][]{\stepcounter{slide}%
\ifframeimages%
\def\Gin@ewidth{}\setkeys{Gin}{#1}%
\ifnotes\else\vfill\fi%
\ifx\Gen@ewidth\@empty\mycgraphics[#1]{#2}\else\mycgraphics[width=\slidewidth,#1]{#2}\fi
\par\strut\hfill{\footnotesize Slide \arabic{slide}}%
\ifnotes\else\vfill\fi%
\fi}%ifframeimages

\newlength{\slidelogoheight}
\ifnotes\setlength{\slidelogoheight}{.4cm}\else\setlength{\slidelogoheight}{1cm}\fi
\newsavebox{\slidelogo}\sbox{\slidelogo}{\includegraphics[height=\slidelogoheight]{jacobs-logo}}
\def\source{Michael Kohlhase}% customize locally
\def\copyrightnotice{\footnotesize\copyright:\hspace{.3ex}{\source}}
\newsavebox{\cclogo}\sbox{\cclogo}{\includegraphics[height=\slidelogoheight]{cc_somerights}}
\newif\ifcchref\cchreffalse
\AtBeginDocument{\@ifpackageloaded{hyperref}{\cchreftrue}{\cchreffalse}}
\def\licensing{\ifcchref\href{http://creativecommons.org/licenses/by-sa/2.5/}{\usebox{\cclogo}}\else{\usebox{\cclogo}}\fi}
\newcommand\miko@slidelabel%
{\vbox to \slidelogoheight{\vss\hbox to \slidewidth%
{\licensing\hfill\copyrightnotice\hfill\arabic{slide}\hfill\usebox{\slidelogo}}}}
\AtBeginDocument{\definecolor{green}{rgb}{0,.5,0}\definecolor{purple}{cmyk}{.3,1,0,.17}}
\def\defemph#1{{\textcolor{magenta}{#1}}}
\def\notemph#1{{\textcolor{magenta}{#1}}}
\def\stDMemph#1{{\textcolor{blue}{#1}}}
\def\@@lec#1{(\textcolor{green}{#1})}
\pgfdeclareimage[width=.9em]{miko@small@dbend}{dangerous-bend}
\def\smalltextwarning{\pgfuseimage{miko@small@dbend}\xspace}
\pgfdeclareimage[width=1.5em]{miko@dbend}{dangerous-bend}
\def\textwarning{\raisebox{-.05cm}{\pgfuseimage{miko@dbend}}\xspace}
\pgfdeclareimage[width=2.5em]{miko@big@dbend}{dangerous-bend}
\def\bigtextwarning{\raisebox{-.05cm}{\pgfuseimage{miko@big@dbend}}\xspace}
\ifnotes\newcommand\titleframe{\maketitle}\else
\newcommand\titleframe{\begin{frame}\titlepage\end{frame}}\fi
\newenvironment{titleframewith}{\begin{frame}\titlepage}{\end{frame}}
\newenvironment{ttitle}{\begin{center}\LARGE\begin{tabular}{|c|}\hline}%
 {\\\hline\end{tabular}\end{center}\vspace{1ex minus 1ex}}
\newenvironment{ttitlejoint}[1]%
{\newbox\boxwith\setbox\boxwith\hbox{\begin{tabular}{c}{\em joint work with}\\#1\end{tabular}}%
\begin{center}\LARGE\begin{tabular}{c}\color{red}}%
{\\\box\boxwith\end{tabular}\end{center}%
\vspace{1ex minus 1ex}}
\newcommand\putgraphicsat[3]{%
 \begin{picture}(0,0)\put(#1){\includegraphics[#2]{#3}}\end{picture}}
\newcommand\putat[2]{\begin{picture}(0,0)\put(#1){#2}\end{picture}}
\ifsectocframes
\if@part\newcounter{mpart}
\newcounter{mchapter}
\newcounter{msection}[mchapter]
\else
\newcounter{msection}
\fi
\newcounter{msubsection}[msection]
\newcounter{msubsubsection}[msubsection]
\newcounter{msubsubsubsection}[msubsubsection]
\ifnotes\else% only in slides
\renewcommand\at@begin@omgroup[3][]{\begin{frame}%
\vfill\Large\centering
\red{\ifcase\section@level\or
\stepcounter{mpart}Part \Roman{mpart}\or%
\stepcounter{mchapter}Chapter \arabic{mchapter}\or
\stepcounter{msection}\if@part\arabic{mchapter}.\fi\arabic{msection}\or
\stepcounter{msubsection}\if@part\arabic{mchapter}.\fi\arabic{msection}.\arabic{msubsection}\or
\stepcounter{msubsubsection}\if@part\arabic{mchapter}.\fi\arabic{msection}.\arabic{msubsection}.\arabic{msubsubsection}.\or
\stepcounter{msubsubsubsection}\if@part\arabic{mchapter}.\fi\arabic{msection}.\arabic{msubsection}.\arabic{msubsubsection}.\arabic{msubsubsubsection}\fi%
\quad #3}\vfill
\end{frame}}
\fi% ifnotes
\fi% ifsectocframes
\expandafter\def\csname Parent2\endcsname{}
\ifnotes
\renewenvironment{columns}%
{\par\noindent\begin{minipage}\slidewidth\centering\leavevmode}%
{\end{minipage}\par\noindent}
\newsavebox\columnbox
\renewenvironment{column}[1]%
{\begin{lrbox}{\columnbox}\begin{minipage}{#1}}%
{\end{minipage}\end{lrbox}\usebox\columnbox}
\fi
\ifproblems\newenvironment{problems}{}{}\else\excludecomment{problems}\fi
\addmetakey{Gin}{mhrepos}
\newcommand\mhframeimage[2][]{\metasetkeys{Gin}{#1}%
\edef\mh@@repos{\mh@currentrepos}%
\ifx\Gin@mhrepos\@empty\frameimage[#1]{\MathHub{\mh@currentrepos/source/#2}}%
\else\frameimage[#1]{\MathHub{\Gin@mhrepos/source/#2}}\fi}
\ifnotes\else\sf\fi
\endinput
%%
%% End of file `mikoslides.cls'.
