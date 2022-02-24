\ProvidesExplClass{mikoslides}{2022/02/24}{3.0.0}{mikoslides Class}
\RequirePackage{l3keys2e}

\keys_define:nn{mikoslides / cls}{
  unknown         .code:n       = {
    \PassOptionsToClass{\CurrentOption}{notesslides}
  }
}
\ProcessKeysOptions{ mikoslides / cls }

\LoadClass{notesslides}
\RequirePackage{mikoslides}
