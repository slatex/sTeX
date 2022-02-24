%%
%% This is file `hwexam.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% hwexam.dtx  (with options: `cls')
%% 
\ProvidesExplClass{hwexam}{2022/02/24}{3.0.0}{homework assignments and exams}
\RequirePackage{l3keys2e}
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{document-structure}
  \PassOptionsToPackage{\CurrentOption}{stex}
  \PassOptionsToPackage{\CurrentOption}{hwexam}
  \PassOptionsToPackage{\CurrentOption}{tikzinput}
}
\ProcessOptions
\LoadClass{document-structure}
\RequirePackage{stex}
\RequirePackage{hwexam}
\RequirePackage{tikzinput}
\RequirePackage{graphicx}
\RequirePackage{a4wide}
\RequirePackage{amssymb}
\RequirePackage{amstext}
\RequirePackage{amsmath}
\newcommand\assig@default@type{\hwexam@assignment@kw}
\def\document@hwexamtype{\assig@default@type}
\keys_define:nn { document-structure / document }{
id .str_set_x:N = \c_document_structure_document_id_str,
hwexamtype .tl_set:N = \document@hwexamtype
}
\endinput
%%
%% End of file `hwexam.cls'.
