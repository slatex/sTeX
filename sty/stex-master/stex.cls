%%
%% This is file `stex.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% stex.dtx  (with options: `cls')
%% 
  %     \item If \meta{path} is empty, then
  %         \meta{name} must have been declared earlier in the same file
  %         and retrievable from \cs{g_stex_modules_in_file_seq}, or
  %         a file with name \meta{name}|.|\meta{lang}|.tex| must exist
  %         in the same folder, containing a module \meta{name}.
  %
  %         That module should have the same namespace as the current one.
  %     \item If \meta{path} is not empty, it must point to the relative
  %         path of the containing file as well as the namespace.
  %         \meta{name} must have been declared earlier in the same file
  %         and retrievable from \cs{g_stex_modules_in_file_seq}, or
  %         a file with name \meta{name}|.|\meta{lang}|.tex| must exist
  %         in the top |source| folder of the archive,
  %         containing a module \meta{name}.
  %
  %         That module should lie directly in the namespace
  %         of the archive.
  %     \item If \meta{path} is not empty, it must point to the
  %         path of the containing file as well as the namespace,
  %         relative to the namespace of the archive.
  %
  %         If a module by that namespace exists, it is returned.
  %         Otherwise, we call \cs{stex_require_module:nn}
  %         on the |source| directory of the archive to find the
  %         file.
\RequirePackage{expl3,l3keys2e}
\ProvidesExplClass{stex}{2021/08/01}{1.9}{bla}
\LoadClass[border=1px,varwidth]{standalone}
\setlength\textwidth{15cm}
\g@addto@macro{\@parboxrestore}{\setlength\parskip{\baselineskip}}

\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{stex}}
\ProcessOptions

\RequirePackage{stex}
\endinput
%%
%% End of file `stex.cls'.
