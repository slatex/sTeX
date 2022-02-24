\RequirePackage{expl3,l3keys2e}
\ProvidesExplClass{smglom}{2022/02/24}{3.0.0}{sTeX1 compatibility}
\LoadClass[border=1px,varwidth]{standalone}
\setlength\textwidth{15cm}
%\g@addto@macro{\@parboxrestore}{\setlength\parskip{\baselineskip}}
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{stex}}
\ProcessOptions

