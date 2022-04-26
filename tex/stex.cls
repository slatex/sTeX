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

\clist_if_empty:NT \c_stex_languages_clist {
  \seq_get_right:NN \g_stex_currentfile_seq \l_tmpa_str
  \seq_set_split:NnV \l_tmpa_seq . \l_tmpa_str
  \seq_pop_right:NN \l_tmpa_seq \l_tmpa_str % .tex
  \exp_args:No \str_if_eq:nnF \l_tmpa_str {tex} {
    \exp_args:No \str_if_eq:nnF \l_tmpa_str {dtx} {
      \exp_args:NNo \seq_put_right:Nn \l_tmpa_seq \l_tmpa_str
    }
  }
  \seq_pop_left:NN \l_tmpa_seq \l_tmpa_str % <filename>
  \seq_if_empty:NF \l_tmpa_seq { %remaining element should be [<something>.]language
    \seq_pop_right:NN \l_tmpa_seq \l_tmpa_str
    \prop_if_in:NoT \c_stex_languages_prop \l_tmpa_str {
      \stex_debug:nn{language} {Language~\l_tmpa_str~
        inferred~from~file~name}
      \exp_args:NNo \stex_set_language:Nn \l_tmpa_str \l_tmpa_str
    }
  }

}
\endinput
%%
%% End of file `stex.cls'.
