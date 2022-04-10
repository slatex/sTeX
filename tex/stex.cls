%%
%% This is file `stex.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% stex-basics.dtx  (with options: `cls')
%% 

%%%%%%%%%%%%%   basics.dtx   %%%%%%%%%%%%%

\RequirePackage{expl3,l3keys2e}
\ProvidesExplClass{stex}{2022/03/03}{3.1.0}{sTeX document class}

\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{stex}}
\ProcessOptions

\bool_set_true:N \c_stex_document_class_bool

\RequirePackage{stex}

\stex_html_backend:TF {
  \LoadClass{article}
}{
  \LoadClass[border=1px,varwidth,crop=false]{standalone}
  \setlength\textwidth{15cm}
}
\RequirePackage{standalone}
\endinput
%%
%% End of file `stex.cls'.
