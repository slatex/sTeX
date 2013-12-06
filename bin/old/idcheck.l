%{
#include <string.h>
int ur,ok,a,lin,i,j,c,n,m,d,s,q,fe,f,for_ok,curr_lin;
typedef char idstr[50];
idstr l[5000], r[5000];
%}

ID [a-zA-Z0-9._:\|-]*
WS [\n\t ]*

%s env inenv fid foc

%% 

"\\begin"{WS}"{"("proof"|"example")"}"{WS}"[" {
fe=1;
for_ok=0;
curr_lin=lin;
BEGIN(env); // stuff that "for" keyval is recommended for
}

"\\begin"{WS}"{"("proof"|"example")"}" if (f) printf("Missing 'for' at line %d\n",lin);

("\\begin"{WS}"{"("definition"|"assertion"|"proof"|"omtext"|"example"|"step"|"pfcase"|"module")"}"{WS}"[")|("\\justification"{WS}"[") {
fe=0;
BEGIN(env);
}

<env>"]" {
if (fe && !for_ok && f) printf("Missing 'for' at line %d\n",curr_lin);
BEGIN(INITIAL);
}

<env>"id"{WS}"="{WS} BEGIN(fid);

<fid>{ID} {
for (i=0; i<yyleng; i++) l[n][i]=yytext[i];
l[n][yyleng]=0;
if (s) printf("%s\n",l[n]);
n++;
BEGIN(env);
}

<env>("for"){WS}"="{WS} {
for_ok=1;
BEGIN(foc);
}
<env>("continues"|"for"|"uses"|"premises"){WS}"="{WS} BEGIN(foc);

<foc>{ID} {
for (j=0; j<yyleng; j++) r[m][j]=yytext[j];
r[m][yyleng]=0;
m++;
BEGIN(env);
}

<env>("premises"|"uses"){WS}"="{WS}"{" BEGIN(inenv);

<inenv>{ID} {
strncpy(r[m],yytext,yyleng);
r[m][yyleng]=0;
m++;
}

<inenv>"}" BEGIN(env);

\n {c++;lin++;}
.  c++;

%%

main(argc, argv)
     int argc;
     char **argv;
{
  if (argc==1) {
    printf("Usage: idcheck [-q | -s | -f] filename(s)\n");
    printf("Option -s shows all detected IDs. \n");
    printf("Option -f shows line numbers for examples and proofs\n          that have 'for' keyval missing. \n");
    printf("Option -q for quiet mode.\n");
  } else{
    s=0; q=0;
    a=1;
    if (argv[1][0]=='-') {
      a++;
      for (j=1; j<strlen(argv[1]); j++)
        if (argv[1][j]=='s') s=1; else
        if (argv[1][j]=='q') q=1; else
        if (argv[1][j]=='f') f=1;
    }   
    d=0;
    while (a<argc){
      if (!q) printf("Parsing %s...\n",argv[a]);
      yyin = fopen(argv[a] , "r");
      c = 0;
      lin = 1;
      n = 0;
      m = 0;
      yylex();
      fclose(yyin);
      if (!q) printf("%d characters skipped. Found %d IDs. \n",c,n);
      if (!q) printf("Checking for duplicates...\n");
      for (i=0; i<n; i++)
        for (j=i+1; j<n; j++)
	  if (strcmp(l[i],l[j])==0) {
	    printf("ID=%s is a duplicate in %s\n",l[i],argv[a]);
            d++;
	  }
      if (!q) printf("Found %d duplicates.\n",d);
      if (!q) printf("Checking references... (found %d)\n",m);
      ur=0;
      for (i=0;i<m; i++){
        ok=0;
        for (j=0; j<n; j++)
          if (strcmp(r[i],l[j])==0){
            ok=1;
            break;
          }
        if (!ok) { 
           printf("Unmatched reference for ID=%s\n",r[i]);
           ur++;
        }
      }
      if (!q) printf("Found %d unmatched references.\n",ur);
      a++;
    }
    return d+ur;
  }
  return 1;
}
