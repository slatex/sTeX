%%
%% This is file `hwexam.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% hwexam.dtx  (with options: `cls')
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{hwexam}[2016/04/06 v1.1 assignment and exam documents]
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
