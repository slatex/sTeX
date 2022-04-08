%%
%% This is file `notesslides.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% notesslides.dtx  (with options: `cls')
%% 
\ProvidesExplClass{notesslides}{2022/02/28}{3.1.0}{notesslides Class}
\RequirePackage{l3keys2e}

\keys_define:nn{notesslides / cls}{
  class   .str_set_x:N = \c__notesslides_class_str,
  notes   .bool_set:N  = \c__notesslides_notes_bool ,
  slides  .code:n      = { \bool_set_false:N \c__notesslides_notes_bool },
  docopt  .str_set_x:N = \c__notesslides_docopt_str,
  unknown .code:n      = {
    \PassOptionsToPackage{\CurrentOption}{document-structure}
    \PassOptionsToClass{\CurrentOption}{beamer}
    \PassOptionsToPackage{\CurrentOption}{notesslides}
  }
}
\ProcessKeysOptions{ notesslides / cls }

\exp_args:No \str_if_eq:nnT\c__notesslides_class_str{book}{
  \PassOptionsToPackage{defaulttopsec=part}{notesslides}
}
\exp_args:No \str_if_eq:nnT\c__notesslides_class_str{report}{
  \PassOptionsToPackage{defaulttopsec=part}{notesslides}
}

\bool_if:NTF \c__notesslides_notes_bool {
  \PassOptionsToPackage{notes=true}{notesslides}
}{
  \PassOptionsToPackage{notes=false}{notesslides}
}
\bool_if:NTF \c__notesslides_notes_bool {
  \str_if_empty:NT \c__notesslides_class_str {
    \str_set:Nn \c__notesslides_class_str {article}
  }
  \exp_after:wN\LoadClass\exp_after:wN[\c__notesslides_docopt_str]
    {\c__notesslides_class_str}
}{
  \LoadClass[10pt,notheorems,xcolor={dvipsnames,svgnames}]{beamer}
  \newcounter{Item}
  \newcounter{paragraph}
  \newcounter{subparagraph}
  \newcounter{Hfootnote}
}
\RequirePackage{document-structure}
\RequirePackage{notesslides}
\endinput
%%
%% End of file `notesslides.cls'.
