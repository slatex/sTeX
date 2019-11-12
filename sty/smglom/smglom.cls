%%
%% This is file `smglom.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% smglom.dtx  (with options: `cls')
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{smglom}[2019/03/20 v0.1 Semantic Multilingual Glossary for Math]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{omdoc}
                           \PassOptionsToPackage{\CurrentOption}{stex}
                           \PassOptionsToPackage{\CurrentOption}{smglom}}
\ProcessOptions
\LoadClass{omdoc}
\RequirePackage{smglom}
\RequirePackage{stex}
\RequirePackage{amstext}
\RequirePackage{amsfonts}
\newenvironment{entry}[2]%
{\item[\textbf{#1}]\mhcurrentrepos{#2}\begin{module}[id=foo]\begin{definition}[display=flow]}
{\end{definition}\end{module}}
\newenvironment{smglossary}{\begin{itemize}}{\end{itemize}}
\newcommand\synonymref[3]{\item[\textbf{#1}] See \textcolor{blue}{\hyperlink{#2}{#3}}}
\newcommand\seeref[3]{\item[\textbf{#1}] Defined along with \textcolor{blue}{\hyperlink{#2}{#3}}}
\endinput
%%
%% End of file `smglom.cls'.
