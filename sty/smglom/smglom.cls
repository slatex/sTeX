%%
%% This is file `smglom.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% smglom.dtx  (with options: `cls')
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{smglom}[2013/05/27 v0.1 Semantic Multilingual Glossary for Math]
\DeclareOption{showmeta}{\PassOptionsToPackage{\CurrentOption}{metakeys}}
\ProcessOptions
\LoadClass{omdoc}
\RequirePackage{amstext}
\RequirePackage{modules}
\RequirePackage{dcm}
\RequirePackage{statements}
\RequirePackage{sproof}
\RequirePackage{cmath}
\RequirePackage{presentation}
\RequirePackage{amsfonts}
\RequirePackage[english,ngerman]{babel}
\RequirePackage{smglom}
\newcommand\hypernym[3][]{#2 is a hypernym of #3}
\newcommand\hyponym[3][]{#2 is a hyponym of  #3}
\newcommand\meronym[3][]{#2 is a meronym of #3}
\newcommand\MSC{\@gobble}
\newcommand\noun[2]{}
\newcommand\qualifier[3]{}
\endinput
%%
%% End of file `smglom.cls'.
