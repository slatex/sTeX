%{

#include <string.h>

char ltxml[100];
char fext[6] = ".ltxml";

char symstr[200];
char ltxmlstr[200];

int i,t,c,tmp,q;
FILE *lt;

%}

ID [a-zA-Z0-9._:\|-]*
NR [0-9]*

%s idenv env sym

%%

"\\begin{module}"(" ")*"[" BEGIN(idenv);
<idenv>"]" BEGIN(INITIAL);

<idenv>"id="{ID} {
  for (i=3; i<yyleng; i++) ltxml[i-3]=yytext[i];
  t=yyleng-3;
  tmp=strlen(fext);
  for (i=0; i<tmp; i++) ltxml[t+i]=fext[i];
  t=t+tmp;
  ltxml[t]=0;
  if (!q) printf("File %s\n",ltxml);
  lt = fopen(ltxml,"w");
  BEGIN(env);
}

<env>"symdef{\\"{ID}"}"(.)* {
i=7;
while (yytext[i]!='}'){
  symstr[i-7]=yytext[i];
  i++;
}
symstr[i-7]=0;
BEGIN(sym);
}

<sym>"latexmldef{"(.)* {
i=11;
while (i<yyleng){
  ltxmlstr[i-11]=yytext[i];
  i++;
}
ltxmlstr[i-12]=0;
fprintf(lt,"DefConstructor('\%s{}...{}','%s')\n",symstr,ltxmlstr);
BEGIN(env);
}

<env,sym>"\\end{module}" {
fclose(lt);
BEGIN(INITIAL);
}

\n c++;
.  c++;

%%

main(argc, argv)
     int argc;
     char **argv;
{
   if (argc==1) {
     printf("arguments expected: [-q] filename(s)\n");
   } else {
    q=0;
    i=1; 
    if (argv[1][0]=='-'){
      i++;
      if (argv[1][1]=='q') q=1;
    }
    while (i<argc){
     if (!q) printf("Processing %s...\n",argv[i]);
     yyin = fopen(argv[i], "r");
     c=0;
     yylex(); 
     fclose(yyin); 
     i++;
    } 
   }
}
