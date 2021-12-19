%%
%% This is file `omdoc.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% omdoc.dtx  (with options: `cls')
%% 
\ProvidesExplClass{omdoc}{2020/10/19}{1.4}{OMDoc Documents}
\RequirePackage{l3keys2e,expl-keystr-compat}
\keys_define:nn{ document-structure / pkg }{
  class       .str_set_x:N  = \c_document_structure_class_str,
  minimal     .bool_set:N   = \c_document_structure_minimal_bool,
  report      .code:n       = {
    \ClassWarning{omdoc}{the option 'report' is deprecated, use 'class=report', instead}
    \str_set:Nn \c_document_structure_class_str {report}
  },
  book        .code:n       = {
    \ClassWarning{omdoc}{the option 'book' is deprecated, use 'class=book', instead}
    \str_set:Nn \c_document_structure_class_str {book}
  },
  bookpart    .code:n       = {
    \ClassWarning{omdoc}{the option 'bookpart' is deprecated, use 'class=book,topsect=chapter', instead}
    \str_set:Nn \c_document_structure_class_str {book}
    \str_set:Nn \c_document_structure_topsect_str {chapter}
  },
  docopt      .str_set_x:N  = \c_document_structure_docopt_str,
  unknown     .code:n       = {
    \PassOptionsToPackage{ \CurrentOption }{ omdoc }
  }
}
\ProcessKeysOptions{ document-structure / pkg }
\str_if_empty:NT \c_document_structure_class_str {
  \str_set:Nn \c_document_structure_class_str {article}
}
\exp_after:wN\LoadClass\exp_after:wN[\c_document_structure_docopt_str]
  {\c_document_structure_class_str}

\RequirePackage{omdoc}
\bool_if:NF \c_document_structure_minimal_bool {
\RequirePackage{stex-compatibility}
\keys_define:nn { document-structure / document }{
  id .str_set_x:N = \c_document_structure_document_id_str
}
\let\__document_structure_orig_document=\document
\renewcommand{\document}[1][]{
  \keys_set:nn{ document-structure / document }{ #1 }
  \stex_ref_new_doc_target:n { \c_document_structure_document_id_str }
  \__document_structure_orig_document
}
}
\endinput
%%
%% End of file `omdoc.cls'.
