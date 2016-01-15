%%
%% This is file `owl2onto.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% owl2onto.dtx  (with options: `cls')
%% 
\DeclareOption{showmeta}{\PassOptionsToPackage{\CurrentOption}{metakeys}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass{article}
\RequirePackage{modules}
\RequirePackage{owl2onto}
\srefaddidkey{ontology}
\addmetakey{ontology}{baseURI}
\newcommand\ontology[1][]{\document\metasetkeys{ontology}{#1}%
\importmodule[owl2]{OWL2}%
\ifx\sref@id\@empty\begin{module}\else\begin{module}[id=\sref@id]\fi}
\newcommand\endontology{\end{module}\enddocument}
\endinput
%%
%% End of file `owl2onto.cls'.
