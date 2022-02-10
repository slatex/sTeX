\ProvidesExplClass{mikoslides}{2022/02/10}{3.0}{mikoslides Class}

\keys_define:nn{mikoslides / cls}{
  unknown         .code:n       = {
    \PassOptionsToClass{\CurrentOption}{notesslides}
  }
}
\ProcessKeysOptions{ mikoslides / cls }

\LoadClass{notesslides}