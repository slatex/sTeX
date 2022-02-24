%%
%% This is file `stex.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% basics.dtx  (with options: `cls')
%% 

%%%%%%%%%%%%%   basics.dtx   %%%%%%%%%%%%%

\RequirePackage{expl3,l3keys2e}
\ProvidesExplClass{stex}{2022/02/24}{3.0.0}{sTeX document class}
\LoadClass[border=1px,varwidth]{standalone}
\setlength\textwidth{15cm}

\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{stex}}
\ProcessOptions

\RequirePackage{stex}
\endinput
%%
%% End of file `stex.cls'.
