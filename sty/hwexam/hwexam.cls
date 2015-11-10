%%
%% This is file `hwexam.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% hwexam.dtx  (with options: `cls')
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{hwexam}[2015/11/04 v1.1 assignment and exam documents]
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{hwexam}
                           \PassOptionsToClass{\CurrentOption}{omdoc}}
\ProcessOptions
\LoadClass{omdoc}
\RequirePackage{stex}
\RequirePackage{hwexam-mh}
\RequirePackage{tikzinput}
\RequirePackage{graphicx}
\RequirePackage{a4wide}
\RequirePackage{amssymb}
\RequirePackage{amstext}
\RequirePackage{amsmath}
\newcommand\assig@default@type{\hwexam@assignment@kw}
\addmetakey[\assig@default@type]{document}{hwexamtype}
\endinput
%%
%% End of file `hwexam.cls'.
