%%
%% This is file `stex.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% stex-basics.dtx  (with options: `cls')
%% 

%%%%%%%%%%%%%   basics.dtx   %%%%%%%%%%%%%

\RequirePackage{expl3,l3keys2e,rustex}
\ProvidesExplClass{stex}{2022/03/03}{3.1.0}{sTeX document class}
\rustex_if:TF {
  \LoadClass{article}
}{
  \LoadClass[border=1px,varwidth]{standalone}
  \setlength\textwidth{15cm}
}

\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{stex}}
\ProcessOptions

\RequirePackage{stex}
\endinput
%%
%% End of file `stex.cls'.
