\ProvidesExplClass{omdoc}{2022/02/10}{3.0}{OMDoc Class}
\RequirePackage{l3keys2e,expl-keystr-compat}

\keys_define:nn{omdoc / cls}{
  unknown         .code:n       = {
    \PassOptionsToClass{\CurrentOption}{document-structure}
  }
}
\ProcessKeysOptions{ omdoc / cls }

\LoadClass{document-structure}