%%
%% This is file `document-structure.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% document-structure.dtx  (with options: `cls')
%% 
\ProvidesExplClass{document-structure}{2022/02/26}{3.0.1}{Modular Document Structure Class}
\RequirePackage{l3keys2e}
\keys_define:nn{ document-structure / pkg }{
  class       .str_set_x:N  = \c_document_structure_class_str,
  minimal     .bool_set:N   = \c_document_structure_minimal_bool,
  report      .code:n       = {
    \ClassWarning{document-structure}{the option 'report' is deprecated, use 'class=report', instead}
    \str_set:Nn \c_document_structure_class_str {report}
  },
  book        .code:n       = {
    \ClassWarning{document-structure}{the option 'book' is deprecated, use 'class=book', instead}
    \str_set:Nn \c_document_structure_class_str {book}
  },
  bookpart    .code:n       = {
    \ClassWarning{document-structure}{the option 'bookpart' is deprecated, use 'class=book,topsect=chapter', instead}
    \str_set:Nn \c_document_structure_class_str {book}
    \str_set:Nn \c_document_structure_topsect_str {chapter}
  },
  docopt      .str_set_x:N  = \c_document_structure_docopt_str,
  unknown     .code:n       = {
    \PassOptionsToPackage{ \CurrentOption }{ document-structure }
  }
}
\ProcessKeysOptions{ document-structure / pkg }
\str_if_empty:NT \c_document_structure_class_str {
  \str_set:Nn \c_document_structure_class_str {article}
}
\exp_after:wN\LoadClass\exp_after:wN[\c_document_structure_docopt_str]
  {\c_document_structure_class_str}

\RequirePackage{document-structure}
\bool_if:NF \c_document_structure_minimal_bool {
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
%% End of file `document-structure.cls'.
