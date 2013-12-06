%{
#include <iostream>
#include <string>
#include <map>
#include <vector>
using namespace std;


const int indent = 4;
const char start_char = '*';

typedef struct {
  vector<string> defs,list;
  int father;
} nodetype;

map<string,nodetype> g;

string vertex, data;
int d, miss, skip;

int max(int, int);

%}

ID [a-zA-Z0-9._:\|-]*
SEP [,;]*
WS [\n\t ]*
M [^}]*

%x in_module found_vertex in_module_cont mdef 
%x found_one_child found_more_children

%%

<INITIAL>"\\begin"{WS}"{module}"{WS}"[" BEGIN(in_module);

<in_module>"id"{WS}"=" BEGIN(found_vertex);
<found_vertex>{ID} {
vertex = YYText();
g[vertex].father=0;
if (miss) cout << endl << "<-------- Module '" << vertex 
               << "' -------->" << endl << endl;
BEGIN(in_module);
}
<in_module>"uses"{WS}"=" BEGIN(found_one_child);
<found_one_child>"{" BEGIN(found_more_children);
<found_more_children>"}" BEGIN(in_module);
<found_one_child>{ID} {
data=YYText();
if (g[data].list.empty()) 
  g[vertex].father=g[data].father+1;
else
  g[vertex].father=max(g[data].father+1,g[vertex].father);
g[data].list.push_back(vertex); 
BEGIN(in_module);
}
<found_more_children>{ID} {
data=YYText();
if (g[data].list.empty()) 
  g[vertex].father=g[data].father+1;
else
  g[vertex].father=max(g[data].father+1,g[vertex].father);
g[data].list.push_back(vertex);
}

<found_one_child,found_more_children,found_vertex>{SEP}|{WS}

<in_module>"]" BEGIN(in_module_cont);

<in_module,in_module_cont>(.|\n)

<in_module_cont>"\\"("symdef"|"abbrdef"|"elldef"|"aliasdef"){WS}"{"{WS} BEGIN(mdef);
<mdef>{M} {
data = YYText();
g[vertex].defs.push_back(data);
}
<mdef>"}" BEGIN(in_module_cont);
<in_module_cont>"\\end"{WS}"{module}" BEGIN(INITIAL);

<INITIAL>(.|\n) if (miss) cout << YYText();

<*>{WS}(%)(.)*(\n)*

%%

void spc(int n){
  for(int i=0; i<n; i++) cout << " ";
}

int max(int a, int b){
  return a>b?a:b;
}

void go(map<string, nodetype > ::iterator node, int depth){
if (skip && node->second.father!=depth) return;
spc(d);
cout << start_char << " " << node->first << "{";
int tmp = node->second.defs.size()-1;
for (int j=0; j<=tmp; j++){
  cout << node->second.defs[j];
  if (j!=tmp) cout << ",";
}
cout << "}" << endl;
d+=indent;
for (int i=0; i<node->second.list.size(); i++)
  go(g.find(node->second.list[i]),depth+1);
d-=indent;
}

int main(int argc, char** argv){
miss=0;
skip=0;
if (argc==2)
   if (argv[1][0]=='-')
     for (int z=1; argv[1][z]!=0; z++) 
       if (argv[1][z]=='m') miss=1; else
       if (argv[1][z]=='s') skip=1; else
       if (argv[1][z]=='h') {
          cout << " Usage: modstr [-s|m|h]\n Input:  stdin\n Output: stdout\n";
          cout << " Options: -s Show module usage only at the deepest level\n";
          cout << "          -m Show text not within a module\n";
          cout << "          -h This help screen\n";
          return 0;
       }
if (miss) cout << "Text NOT within a module:\n" << endl;
FlexLexer* lex = new yyFlexLexer;
lex->yylex();
d=0;
map<string, nodetype > ::iterator start = g.begin();
map<string, nodetype > ::iterator stop = g.end();
cout << endl;
for(;stop!=start;start++) 
  if (!start->second.father) go(start,0);
cout << endl;
return 0;
}
