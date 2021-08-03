%%
%% This is file `stex.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% stex.dtx  (with options: `cls')
%% 
\RequirePackage{expl3,l3keys2e}
\ProvidesExplClass{stex}{2021/08/01}{1.9}{bla}
\LoadClass[border=1px,varwidth]{standalone}
\setlength\textwidth{15cm}
\g@addto@macro{\@parboxrestore}{\setlength\parskip{\baselineskip}}

\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{stex}}
\ProcessOptions

\message{^^J\meaning\l_stex_cls_option_clist ^^J}

\RequirePackage{stex}
\endinput
%%
%% End of file `stex.cls'.
