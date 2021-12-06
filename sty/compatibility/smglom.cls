\RequirePackage{expl3,l3keys2e}
\ProvidesExplClass{smglom}{2021/08/01}{1.9}{sTeX1 compatibility}
\LoadClass[border=1px,varwidth]{standalone}
\setlength\textwidth{15cm}
%\g@addto@macro{\@parboxrestore}{\setlength\parskip{\baselineskip}}
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{stex}}
\ProcessOptions

\RequirePackage{stex-compatibility}
