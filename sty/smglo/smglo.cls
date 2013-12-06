%%
%% This is file `smglo.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% smglo.dtx  (with options: `cls')
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{smglo}[2013/05/27 v0.1 Semantic Multilingual Glossary for Math]
\DeclareOption{showmeta}{\PassOptionsToPackage{\CurrentOption}{metakeys}}
\ProcessOptions
\LoadClass{omdoc}
\RequirePackage{amstext}
\RequirePackage{modules}
\RequirePackage{statements}
\RequirePackage{cmath}
\RequirePackage{presentation}
\RequirePackage{amsfonts}
\RequirePackage[english,ngerman]{babel}
\newcommand\ginput[2][]{\input{#2}\@for\@I:=#1\do{\input{#2.\@I}}}
\newcommand\gimport[2][]{\def\@test{#1}%
\ifx\@test\@empty\importmodule[load=#2]{#2}\else\importmodule[#1,load=#2]{#2}\fi}
\newcommand\guse[2][]{\def\@test{#1}%
\ifx\@test\@empty\usemodule[load=#2]{#2}\else\usemodule[#1,load=#2]{#2}\fi}
\newcommand\gadopt[2][]{\def\@test{#1}%
\ifx\@test\@empty\gadoptmodule[load=#2]{#2}\else\gadoptmodule[#1,load=#2]{#2}\fi}
\newenvironment{gview}[3][]%
{\def\@test{#1}\ifx\@test\@empty\begin{view}[from=#2,to=#3]{#2}{#3}\else\begin{view}[from=#2,to=#3,#1]{#2}{#3}\fi}
{\end{view}}
\newenvironment{gviewsketch}[3][]%
{\def\@test{#1}\ifx\@test\@empty\begin{viewsketch}[from=#2,to=#3]{#2}{#3}\else\begin{viewsketch}[from=#2,to=#3,#1]{#2}{#3}\fi}
{\end{viewsketch}}
\def\@@en{en}\def\@@de{de}
\newenvironment{gve}[5][]{\def\@test{#1}%
\ifx\@test\@empty\begin{gviewsketch}[id=#2.#3]{#4}{#5}\else\begin{gviewsketch}[id=#2.#3,#1]{#4}{#5}\fi
\def\@test{#3}%
\ifx\@test\@@en\selectlanguage{english}\fi
\ifx\@test\@@de\selectlanguage{ngerman}\fi}
{\end{gviewsketch}}
\def\symbol{\@ifstar\@gobble\@gobble}
\newcommand\hypernym[3][]{#2 is a hypernym of #3}
\newcommand\hyponym[3][]{#2 is a hyponym of  #3}
\newcommand\meronym[3][]{#2 is a meronym of #3}
\newcommand\MSC{\@gobble}
\def\@@en{en}\def\@@de{de}
\newenvironment{gle}[3][]{\def\@test{#1}%
\ifx\@test\@empty\begin{module}[id=#2.#3]\else\begin{module}[id=#2.#3,#1]\fi
\gimport{#2}\def\@test{#3}%
\ifx\@test\@@en\selectlanguage{english}\fi
\ifx\@test\@@de\selectlanguage{ngerman}\fi}
{\end{module}}
\newcommand\noun[2]{}
\newcommand\qualifier[3]{}
\endinput
%%
%% End of file `smglo.cls'.
