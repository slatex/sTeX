%%
%% This is file `stex.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% stex.dtx  (with options: `cls')
%% 
\ProvidesClass{stex}[2021/03/08 v2.0 Semantic Markup]
\RequirePackage{xkeyval}
\DeclareOptionX{lang}{\def\stex@babeloption{#1}}
\DeclareOptionX*{\PassOptionsToPackage{\CurrentOption}{stex}}
\ProcessOptionsX
\LoadClass[border=1px,varwidth]{standalone}
\setlength\textwidth{15cm}
\g@addto@macro{\@parboxrestore}{\setlength\parskip{\baselineskip}}
\usepackage{stex}
\ifcsvoid{stex@babeloption}{}{
  \ifcsvoid{stex@babel@long\stex@babeloption}{
    \PackageError{stex}{Unknown language shortcode: \stex@babeloption}{}
  }{
    \RequirePackage[\csname stex@babel@long\stex@babeloption\endcsname]{babel}
  }
}
\endinput
%%
%% End of file `stex.cls'.