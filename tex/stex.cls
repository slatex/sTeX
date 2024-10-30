%%
%% This is file `stex.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% stex.dtx  (with options: `cls')
%% 
%%%%%%%%%%%%%   stex.dtx   %%%%%%%%%%%%%

\RequirePackage{expl3,l3keys2e}
\ProvidesExplClass{stex}{2023/10/13}{4.0.0}{sTeX document class}
\IfFileExists{stex-expl-compat.sty}{
  \usepackage{stex-expl-compat}
}{}

\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{stex}}
\ProcessOptions

\RequirePackage{stex}

\LoadClass{article}
\endinput
%%
%% End of file `stex.cls'.
