#!/usr/bin/perl
use Cwd;

die 'Set your environment variable "KWARC_HOME" and try again.' if !($ENV{KWARC_HOME});

open(PATH_STY,"$ENV{KWARC_HOME}/projects/stex/sty/paths.sty") || die "can't open path.sty";
while  ($line=<PATH_STY>) {
  $line =~ m/\\def\\(\w*).*\/([\w-]*)\/#1/;
  $macros{$2}=$1; # dir -> macro
}
close(PATH_STY);

print <<PRE_TEX;
\\documentclass[notes]{mikoslides}
\\usepackage{amssymb}
\\usepackage{latexml,stex,program}
\\usepackage{ded,calbf,myindex}
\\usepackage{tikz,multicol}
\\usepackage{paths}
\\usepackage[show]{ed}
\\def\\bsp{\\sl\\color{green}}
\\def\\hrcr#1#2{#2}

\\begin{document}
PRE_TEX

chdir("$ENV{KWARC_HOME}/teaching/snippets/");

foreach $dir (<*/>) {
  $dir = substr($dir,0,-1);
  if (@ARGV){ # take all dirs listet in @ARGV
    next if !(grep(/$dir/,@ARGV))
  } else { # take all dirs but those listed here
    #  next if $dir lt "b"; #test break
    #  next if $dir gt "comb"; #test break
    next if grep(/$dir/,qw(PIC activemath admin eLearning lib kwarc mathweb mbase old.assignments omdoc openmath physml quantumcomputing sTex search semweb setthy spl1 term-indexing trs varia xml)); #skip these
    next if grep(/$dir/,qw(ai codeml fa graphs-trees kr mws nlfrags pl0 pl1 prolog regexp)); #broken dirs
  }
  print "\\begin{omgroup}{$dir}\n";
  foreach $file (<${dir}/en/*.sms>) {
    $file =~ m/([^\/]*).sms/;
    $prefix = $1;
    next if grep(/$prefix/,qw(all admin));
    print "\\begin{omgroup}{$prefix}\n";
    print "\\requiremodules[exclude]{\\$macros{$dir}\{en/$prefix}\}\n";
    open (FILE,"./$file") || die "can't open $file";
     while ($line=<FILE>) {
       $line =~ s/%.*//;
       if ($line =~ m/begin{module}/) { # many "begin{module}" in one line yields invalid stex!!!
	 $uses = ($line =~ m/id=([\w-]*)/) ? "[uses=$1]" : "";
	 print "\\begin{module}$uses\n"; # symbols after inner modules yields stex errors!!!
	 print "\\begin{verbatim}\n";
	 print "\\requiremodules[exclude]{\\$macros{$dir}\{en/$prefix}\}\n";
	 print "\\begin{module}$uses\n";
	 print "\\end{verbatim}\n";
#	 print "\\begin{multicols}{2}\n";
       }
       if ($line =~ m/\\symdef{([^}]*)}(?:\[(\d)\])?({\\assoc\[)?/) {
	 $symb = $1;
	 $arity = $2;
	 $isAssoc = $3 ne "";
	 $defArity = $isAssoc ? 4 : $arity;
	 $exampleArity = $arity eq "" ? 0 : $defArity;
	 $arityOrAssoc = $isAssoc ? "assoc" : $arity;
	 $dummy_args = join("",map {"{$_}"} (qw(a b c d e f g h m)[0..$exampleArity-1]));
	 $dummy_args = "{a,b,c,d}" if $isAssoc;
	 $escaped_dummy_args = $dummy_args;
	 $escaped_dummy_args =~ s/{/\\{/g;
	 $escaped_dummy_args =~ s/}/\\}/g;
#	 print "{\\tt{$symb\[$arityOrAssoc\]}} $escaped_dummy_args\\hfill";
	 print "{\\tt{$symb$escaped_dummy_args}} \\hfill ";
	 print "\$\\$symb$dummy_args\$\\\\\n";
        }
       if ($line =~ m/end{module}/) { # several "end{mdoule}" allowed!!!
#	 print "\\end{multicols}\n";
	 print $line;
       }
     }
    close(FILE);
    print "\\end{omgroup}\n";
  }
  print "\\end{omgroup}\n";
}

print "\\end{document}";
