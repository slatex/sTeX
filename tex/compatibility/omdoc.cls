\ProvidesExplClass{omdoc}{2022/02/24}{3.0.0}{OMDoc Class}
\RequirePackage{l3keys2e}

\keys_define:nn{omdoc / cls}{
  unknown         .code:n       = {
    \PassOptionsToClass{\CurrentOption}{document-structure}
  }
}
\ProcessKeysOptions{ omdoc / cls }

\LoadClass{document-structure}