%%
%% This is file `mikoslides.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% mikoslides.dtx  (with options: `cls')
%% 
\ProvidesExplClass{mikoslides}{2020/12/06}{1.3}{MiKo slides Class}
\RequirePackage{l3keys2e,expl-keystr-compat}

\keys_define:nn{mikoslides / cls}{
  class   .code:n   = {
    \PassOptionsToClass{\CurrentOption}{omdoc}
    \str_if_eq:nnT{#1}{book}{
      \PassOptionsToPackage{defaulttopsec=part}{mikoslides}
    }
    \str_if_eq:nnT{#1}{report}{
      \PassOptionsToPackage{defaulttopsec=part}{mikoslides}
    }
  },
  notes   .bool_set:N  = \c__mikoslides_notes_bool ,
  slides  .code:n      = { \bool_set_false:N \c__mikoslides_notes_bool },
  unknown .code:n      = {
    \PassOptionsToClass{\CurrentOption}{omdoc}
    \PassOptionsToClass{\CurrentOption}{beamer}
    \PassOptionsToPackage{\CurrentOption}{mikoslides}}
  }
}
\ProcessKeysOptions{ mikoslides / cls }
\bool_if:NTF \c__mikoslides_notes_bool {
  \PassOptionsToPackage{notes=true}{mikoslides}
}{
  \PassOptionsToPackage{notes=false}{mikoslides}
}
\bool_if:NTF \c__mikoslides_notes_bool {
  \LoadClass{omdoc}
}{
  \LoadClass[10pt,notheorems,xcolor={dvipsnames,svgnames}]{beamer}
  \newcounter{Item}
  \newcounter{paragraph}
  \newcounter{subparagraph}
  \newcounter{Hfootnote}
  \RequirePackage{omdoc}
}
\RequirePackage{mikoslides}
\endinput
%%
%% End of file `mikoslides.cls'.
