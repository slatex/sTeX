%%
%% This is file `notesslides.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% notesslides.dtx  (with options: `cls')
%% 
\ProvidesExplClass{notesslides}{2024/10/26}{4.0.0}{notesslides Class}
\RequirePackage{l3keys2e}

\str_const:Nn \c__notesslides_class_str {article}

\keys_define:nn{notesslides / cls}{
  class   .str_set_x:N = \c__notesslides_class_str,
  notes   .bool_set:N  = \c_notesslides_notes_bool ,
  slides  .code:n      = { \bool_set_false:N \c_notesslides_notes_bool },
  %docopt  .str_set_x:N = \c__notesslides_docopt_str,
  unknown .code:n      = {
    \PassOptionsToClass{\CurrentOption}{beamer}
    \PassOptionsToClass{\CurrentOption}{\c__notesslides_class_str}
    \PassOptionsToPackage{\CurrentOption}{notesslides}
    \PassOptionsToPackage{\CurrentOption}{stex}
  }
}
\ProcessKeysOptions{ notesslides / cls }

\RequirePackage{stex}
\stex_if_html_backend:T {
  \bool_set_true:N\c_notesslides_notes_bool
}

\bool_if:NTF \c_notesslides_notes_bool {
  \PassOptionsToPackage{notes=true}{notesslides}
  \message{notesslides.cls:~Formatting~document~in~notes~mode}
}{
  \PassOptionsToPackage{notes=false}{notesslides}
  \message{notesslides.cls:~Formatting~document~in~slides~mode}
}

\bool_if:NTF \c_notesslides_notes_bool {
  \LoadClass{\c__notesslides_class_str}
}{
  \LoadClass[10pt,notheorems,xcolor={dvipsnames,svgnames}]{beamer}
  %\newcounter{Item}
  %\newcounter{paragraph}
  %\newcounter{subparagraph}
  %\newcounter{Hfootnote}
}
\RequirePackage{notesslides}
\endinput
%%
%% End of file `notesslides.cls'.
