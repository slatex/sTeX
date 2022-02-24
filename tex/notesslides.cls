%%
%% This is file `notesslides.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% notesslides.dtx  (with options: `cls')
%% 
\ProvidesExplClass{notesslides}{2022/02/10}{3.0}{notesslides Class}
\RequirePackage{l3keys2e}

\keys_define:nn{notesslides / cls}{
  class   .code:n   = {
    \PassOptionsToClass{\CurrentOption}{document-structure}
    \str_if_eq:nnT{#1}{book}{
      \PassOptionsToPackage{defaulttopsec=part}{notesslides}
    }
    \str_if_eq:nnT{#1}{report}{
      \PassOptionsToPackage{defaulttopsec=part}{notesslides}
    }
  },
  notes   .bool_set:N  = \c__notesslides_notes_bool ,
  slides  .code:n      = { \bool_set_false:N \c__notesslides_notes_bool },
  unknown .code:n      = {
    \PassOptionsToClass{\CurrentOption}{document-structure}
    \PassOptionsToClass{\CurrentOption}{beamer}
    \PassOptionsToPackage{\CurrentOption}{notesslides}
  }
}
\ProcessKeysOptions{ notesslides / cls }
\bool_if:NTF \c__notesslides_notes_bool {
  \PassOptionsToPackage{notes=true}{notesslides}
}{
  \PassOptionsToPackage{notes=false}{notesslides}
}
\bool_if:NTF \c__notesslides_notes_bool {
  \LoadClass{document-structure}
}{
  \LoadClass[10pt,notheorems,xcolor={dvipsnames,svgnames}]{beamer}
  \newcounter{Item}
  \newcounter{paragraph}
  \newcounter{subparagraph}
  \newcounter{Hfootnote}
  \RequirePackage{document-structure}
}
\RequirePackage{notesslides}
\endinput
%%
%% End of file `notesslides.cls'.
