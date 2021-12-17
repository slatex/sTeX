%%
%% This is file `hwexam.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% hwexam.dtx  (with options: `cls')
%% 
\ProvidesExplClass{hwexam}{2019/03/20}{1.1}{homework assignments and exams}
\RequirePackage{l3keys2e,expl-keystr-compat}
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{omdoc}
  \PassOptionsToPackage{\CurrentOption}{stex}
  \PassOptionsToPackage{\CurrentOption}{hwexam}
  \PassOptionsToPackage{\CurrentOption}{tikzinput}
}
\ProcessOptions
\LoadClass{omdoc}
\RequirePackage{stex}
\RequirePackage{hwexam}
\RequirePackage{tikzinput}
\RequirePackage{graphicx}
\RequirePackage{a4wide}
\RequirePackage{amssymb}
\RequirePackage{amstext}
\RequirePackage{amsmath}
\newcommand\assig@default@type{\hwexam@assignment@kw}
\addmetakey[\assig@default@type]{document}{hwexamtype}
\def\document@hwexamtype{\assig@default@type}
\endinput
%%
%% End of file `hwexam.cls'.
