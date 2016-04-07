# anything that starts with # is removed until \n (considered as a comment)
# except in literals; 
# 
# NCName is limited to a-zA-Z0-9.-_
#
# no proper support for except nameClass
# no support for exceptPatterns

package ModelRNC;

use strict;
use File::Basename;

my $DOCUMENT = '_Document_';

sub new{
    my ($class) = @_;
    my $self = {};
    $self->{literalCount} = 0;
    bless($self, $class);
}

# this is the main method of the package
# it should be called right after new
sub process{
    my ($self, $filename) = @_;
    $self->readfile($filename);
    $self->clean_rnc;
    $self->read_topLevel;
    $self->build_info;
    # free some memory
    $self->{DATA} = ''; $self->{FILEPATH} = ''; $self->{GRAPH} = '';
}

sub Error{
    my ($self, $msg) = @_;
    print "'$self->{DATA}'\n";
    die $msg."\n";
}

# read a file into $storage;
# or $self->{DATA} if $storage not given
sub readfile{
    my ($self, $filename, $storage) = @_;

    # NOTE: this is not exactly perfect
    if ($self->{FILEPATH}){
	$filename = $self->{FILEPATH}.$filename unless -e $filename; }
    my $basepath = dirname($filename);
    $basepath .= '/' if ($basepath && $basepath !~ m|/$|);
    $self->{FILEPATH} = $basepath;

    open(FIN, $filename) or $self->Error("Cout not open '$filename'");
    my @data = <FIN>;
    close(FIN);
    
    # for use in namespace set selection
    push(@{$self->{LOADEDFILES}}, $filename);
    
    if (defined $storage){ $$storage = join('',@data); }
    else { $self->{DATA} = join('',@data); }
}

# remove lines after ## 
sub remove_annotations{
    my ($self, $data) = @_;
    $data = \$self->{DATA} unless $data;
    do {} while ($$data =~ s/\[[^\]\[]*\]//g);
    $$data =~ s/\#\#[^\n]*//g;
}

# remove all lines that start with # except
# the ones that start with ##
sub remove_comments{
    my ($self, $data) =@_;
    $data = \$self->{DATA} unless $data;
    $$data =~ s/\#[^\#\n][^\n]*//g;
    $$data =~ s/\#\n/\n/g;
}

sub scan_literals{
    my ($self, $data) = @_;
    my @litseg; my $seg = 0;
    $data = \$self->{DATA} unless $data;
    while ($$data =~ s/\"\"\"((\"{0,2}[^\"])*)\"\"\"/_LITSEG$seg/) { $litseg[$seg++] = $1; }
    while ($$data =~ s/\'\'\'((\'{0,2}[^\'])*)\'\'\'/_LITSEG$seg/) { $litseg[$seg++] = $1; }
    while ($$data =~ s/\"([^\"\n]*)\"/_LITSEG$seg/) { $litseg[$seg++] = $1; }
    while ($$data =~ s/\'([^\'\n]*)\'/_LITSEG$seg/) { $litseg[$seg++] = $1; }
    
    while ($$data =~ s/_LITSEG(\d+)\s*~\s*_LITSEG(\d+)/_LITSEG$seg/) 
    { $litseg[$seg++] = $litseg[$1].$litseg[$2]; }
    
    while ($$data =~ s/_LITSEG(\d+)/!LIT$self->{literalCount}/) 
    { $self->{literals}[$self->{literalCount}++] = $litseg[$1]; }
}

# remove \x{N} sections
sub special_chars{
    my ($self, $data) = @_;
    $data = \$self->{DATA} unless $data;
    while ($$data =~ m/\\x\{([a-fA-F0-9x]+)\}/g){
	my $lng = length($&); my $p = pos($$data) - $lng;
	substr($$data, $p, $lng) = chr(hex($1));
	pos($$data) = $p + 1;
    }
}

# remove redundant data from loaded file
sub clean_rnc{
    my ($self, $data) = @_;
    $data = \$self->{DATA} unless $data;
    $self->scan_literals($data);
    $self->special_chars($data);
    $self->remove_annotations($data);
    $self->remove_comments($data);
    # add a newline, just in case the last word is a keyword
    # and for nice printing;
    $$data.="\n";
}

# in the processing of the data, the data is destroyed
# provide two methods for resolving that
sub backup{
    my ($self) = @_;
    $self->{BACKUP_DATA} = $self->{DATA};
}

sub restore{
    my ($self) = @_;
    $self->{DATA} = $self->{BACKUP_DATA} if defined $self->{BACKUP_DATA};
}

# set or retrieve stored data
sub data{
    my ($self, $newdata) = @_;
    if (defined $newdata){ $self->{DATA} = $newdata; }
    else { return $self->{DATA}; }
}

# put back some extracted string from DATA
sub put_back{
    my ($self, $back) = @_;
    substr($self->{DATA}, 0, 0) = $back;
}

# try to match a keyword; return 1 on success; 0 on failure
# NOTE: this implies that the used keywords should be followed by
# some non alphanumeric or space character
sub read_keyword{
    my ($self, $keyword) = @_;
    return 0 if ($self->{DATA} !~ /^\s*\Q$keyword\E\s*[^a-zA-Z0-9_\-\.]/);
    substr($self->{DATA}, 0, length($&)-1) = '';
    return 1;
}

# same as read_keyword, except it dies not expect a non-word character 
# after the word it searches
sub read_controlword{
    my ($self, $controlword) = @_;
    return 0 if ($self->{DATA} !~ /^\s*\Q$controlword\E\s*/);
    substr($self->{DATA},0,length($&)) = '';
    return 1;
}

# expect a keyword; if the word is found, it is extracted
# otherwise, the program dies (the grammar is incorrect)
sub expect_keyword{
    my ($self, $keyword) = @_;
    $self->Error("Expected keyword '$keyword' was not found") 
	if ($self->{DATA} !~ /^\s*\Q$keyword\E\s*/);
    substr($self->{DATA}, 0, length($&)) = '';
}


# Does not include Extender and CombiningChar 
# (as in XML Namespaces: http://www.w3.org/TR/REC-xml/)
sub read_NCName{
    my ($self, $terminators) = @_;
    my $termin_exists = 1;
    if (defined $terminators) { $terminators = "[$terminators]"; }
    else { $terminators = ''; $termin_exists = 0; }
    if ($self->{DATA} =~ /^\s*([_a-zA-Z][_a-zA-Z0-9\.\-]*)\s*$terminators/){
	substr($self->{DATA}, 0, length($&)-$termin_exists) = '';
	return $1;
    }
    return undef;
}

# try to match an identifierOrKeyword; return it in case 
# of success; return undef in case of failure;
sub read_identifierOrKeyword{
    my ($self, $terminators) = @_;
    $self->read_controlword('\\');
    return $self->read_NCName($terminators);
}

# see if the argument is in the set of defined keyword of RelaxNG
sub isRNCKeyword{
    my ($word) = @_;
    return ($word =~ /^\s*(attribute|default|datatypes|div|element|empty|external|grammar|include|inherit|list|mixed|namespace|notAllowed|parent|start|string|text|token)\s*$/);
}

# read an identifier; return undef if no identifier can be read
sub read_identifier{
    my ($self, $terminators) = @_;
    my $quote = $self->read_controlword('\\');
    my $ident = $self->read_NCName($terminators);
    if (!$quote && $ident && isRNCKeyword($ident)){
	$self->put_back($ident);
	return undef;
    }
    return $ident;
}

# read a literal in any form given;
# segments are taken into account
sub read_literal{
    my ($self) = @_;
    if ($self->{DATA} =~ /^\s*!LIT(\d+)\s*/){
	substr($self->{DATA}, 0, length($&)) = '';
	return $self->{literals}[$1];
    }
    return undef;
}

# read a namespace URI literal
sub read_namespaceURILiteral{
    my ($self, $inherited_namespace) = @_;
    return $inherited_namespace if $self->read_keyword('inherit');
    return $self->read_literal;
}

# read any URI literal
sub read_anyURILiteral{
    my ($self) = @_;
    $self->read_literal; }

sub getNS{
    my ($self, $nspref) = @_;
    $self->{${$self->{LOADEDFILES}}[$#{$self->{LOADEDFILES}}]}->{NAMESPACE}{$nspref}; }

sub setNS{
    my ($self, $nspref, $nsval) = @_;
    $self->{${$self->{LOADEDFILES}}[$#{$self->{LOADEDFILES}}]}->{NAMESPACE}{$nspref} = $nsval; }

# read all declarations, until none can be read
sub read_decl{
    my ($self, $inherited_namespace) = @_;
    $inherited_namespace = '' unless defined $inherited_namespace;
    $self->setNS('default',$inherited_namespace) unless $self->getNS('default');
    my $found = 1;
    while ($found){
	if ($self->read_keyword('namespace')){
	    my $namespace_name = $self->read_identifierOrKeyword('=');
	    $self->Error('Undefined namespace name') unless $namespace_name;
	    $self->expect_keyword('=');
	    my $namespace_value = 
		$self->read_namespaceURILiteral($inherited_namespace);
	    $self->Error('Undefined namespace URI') 
		unless defined $namespace_value;
	    $self->setNS($namespace_name, $namespace_value);
	}	
	elsif ($self->read_keyword('default') && 
	    $self->read_keyword('namespace')){
	    my $namespace_name = undef;
	    if (!$self->read_controlword('=')){
		$namespace_name = $self->read_identifierOrKeyword('=');
		$self->Error('Undefined namespace name') 
		    unless $namespace_name;
		$self->expect_keyword('=');
	    }
	    my $namespace_value = 
		$self->read_namespaceURILiteral($inherited_namespace);
	    $self->Error('Undefined namespace URI') 
		unless defined $namespace_value;
	    $self->setNS('default', $namespace_value);
	    $self->setNS($namespace_name, $namespace_value)
		if $namespace_name;
	}	
	elsif ($self->read_keyword('datatypes')){
	    my $datatype_name = $self->read_identifierOrKeyword('=');
	    $self->Error('Undefined datatype name') unless $datatype_name;
	    $self->expect_keyword('=');
	    my $datatype_value = $self->read_literal;
	    $self->Error('Undefined datatype value') 
		unless defined $datatype_value;
	}
	else { $found = 0; }
    }
}

# ignore an annotation definition; 
# (assumes annotation content does not exist)
# (it has been removed by clean_rnc)
sub ignore_annotation{
    my ($self) = @_;
    $self->read_CName; }

# read a name (CName) of the form NCName:NCName 
sub read_CName{
    my ($self, $terminators) = @_;   
    $terminators = '\s' unless defined $terminators; 
    my $name = $self->read_NCName(':');
    if ($name){
	$self->expect_keyword(':');
	my $part2 = $self->read_NCName($terminators);
	$self->Error('Incomplete CName definition') unless $part2;
	$name .= ":$part2";
    }
    return $name;
}

# read a datatype name
sub read_datatypeName{
    my ($self, $terminators) = @_;
    $terminators = '\s' unless defined $terminators;
    if ($self->{DATA} =~ /^\s*string\s*[$terminators]/){
	substr($self->{DATA},0,length($&)-1) = '';
	return 'string';
    }
    elsif ($self->{DATA} =~ /^\s*token\s*[$terminators]/){
    	substr($self->{DATA},0,length($&)-1) = '';
	return 'token';
    } else {
	return $self->read_CName($terminators);
    }
}

# read a datatype value
sub read_datatypeValue{
    my ($self) = @_;
    return $self->read_literal;
}

# return the set of names an element or an attribute can have
# this does not work well on complicated name classes
sub read_nameClassEx{
    my ($self, $terminators) = @_;

    my @result;

    if ($self->read_controlword('(')){
	@result = $self->read_nameClassEx($terminators.'\)');
	$self->expect_keyword(')');
    } else {
	
	#anyName
	if ($self->read_controlword('*')){
	    push(@result, '*');
	    if ($self->read_controlword('-')){
		print STDERR "Warning: USE OF EXCEPT NAMECLASS NOT IMPLEMENTED\n";
		push(@result, $self->read_nameClassEx($terminators));
	    }
	}
	# nsName or name(CName)
	elsif (my $part1 = $self->read_NCName(':')){
	    $self->expect_keyword(':');
	    if ($self->read_controlword('*')){ 
		push(@result, "$part1:*");
		if ($self->read_controlword('-')){
		    print STDERR 
			"Warning: USE OF EXCEPT NAMECLASS NOT IMPLEMENTED\n";
		    push(@result, '-', 
			 $self->read_nameClassEx($terminators));
		}
	    } else {
		push(@result, $part1.':'.$self->read_NCName($terminators.'\|'));
	    }	
	}
	# name(identifierOrKeyword)
	else {
	    my $name = $self->read_identifierOrKeyword($terminators.'\|');
	    $self->Error('Incomplete name class given') unless $name;
	    push(@result, $name);
	}	
    }

    $self->Error('No name class provided') unless @result;
    
    # see if we have more possible names:
    push(@result, $self->read_nameClassEx($terminators))
	if ($self->read_controlword('|'));
    
    return @result;
}

sub read_nameClass{
    my ($self, $terminators, @parents) = @_;
    $terminators = '\s' unless defined $terminators;
    my @result = $self->read_nameClassEx($terminators);
    my @finalRes;

    if (@parents && @result){

	my @nsList, my %saw = ();
	foreach (@parents){
	    if (/\{(.*)\}:.+/){
		next if $saw{$1};
		push(@nsList, $1); $saw{$1} = 1; } 
	    else {
		next if $saw{'default'};
		push(@nsList, $self->getNS('default')); $saw{'default'} = 1; }
	}
	
	foreach my $res(@result){
	    if ($res =~ /(.+):(.+)/){
		push(@finalRes, $self->ns_prepend($2, $1)); }
	    else {
		map(push(@finalRes, "{$_}:$res"), @nsList); }
	}
    } else {
	map(push(@finalRes, (/(.+):(.+)/)?
		 $self->ns_prepend($2, $1):$self->ns_prepend($_)), @result);
    }
    return @finalRes;
}


# read a parameter declaration, if one exists
sub read_param{
    my ($self) = @_;
    my $id = $self->read_identifierOrKeyword('=');
    return (undef, undef) unless $id;
    $self->expect_keyword('=');
    my $val = $self->read_literal;
    $self->Error('No parameter value specified') unless defined $val;
    return ($id, $val);
}

sub begin_read_newfile{
    my ($self) = @_;
    my $file = $self->read_anyURILiteral;
    my $inherit = 'default';
    if ($self->read_keyword('inherit')){
	$self->expect_keyword('=');
	$inherit = $self->read_identifierOrKeyword; }
    $inherit = $self->getNS($inherit);
    my $newdata = '';
    $self->readfile($file, \$newdata);
    $self->clean_rnc(\$newdata);
    $self->put_back($newdata.'#');
    $self->read_decl($inherit); }

sub end_read_newfile{
    my ($self) = @_;
    pop(@{$self->{LOADEDFILES}});
    $self->expect_keyword('#'); }

# read a pattern
sub read_pattern{
    my ($self, $grammarPath, $grammarIdent, @parentElements) = @_;
    my $found = 1; my $grammarCount = 0; 
    my $DEF = $grammarPath.':'.$grammarIdent;

    if ($self->read_keyword('element')){
	my @elementNames = $self->read_nameClass('{', @parentElements); 
	$self->Error('Unspecified element name') unless @elementNames;
	map(push(@{$self->{GRAPH}->{$DEF}->{$_}{ELEMENTS}}, 
		 @elementNames), @parentElements);
	$self->expect_keyword('{');
	$self->read_pattern($grammarPath, $grammarIdent, @elementNames);
	$self->expect_keyword('}');
    }    
    elsif ($self->read_keyword('attribute')){
	my @attributeNames = $self->read_nameClass('{');
	$self->Error('Unspecified attribute name') unless @attributeNames;
	map(push(@{$self->{GRAPH}->{$DEF}->{$_}{ATTRIBUTES}}, 
		 @attributeNames), @parentElements);
	$self->expect_keyword('{');
	$self->read_pattern($grammarPath, $grammarIdent, @parentElements);
	$self->expect_keyword('}');
    }
    elsif ($self->read_keyword('list') || $self->read_keyword('mixed')){
	$self->expect_keyword('{');
	$self->read_pattern($grammarPath, $grammarIdent, @parentElements);
	$self->expect_keyword('}');
    }
    elsif ($self->read_controlword('(')){
	$self->read_pattern($grammarPath, $grammarIdent, @parentElements);
	$self->expect_keyword(')');
    }
    elsif (my $datatypeValue =
	   $self->read_datatypeValue){
	# do nothing
    }
    elsif (my $datatypeName = 
	   $self->read_datatypeName('\s\{\}\-!')){       
	my $datatypeValue = $self->read_datatypeValue;

	# read parameters; ignore them for now
	if ($self->read_controlword('{')){
	    my ($ident, $val);
	    do{
		($ident, $val) = $self->read_param;
	    } while ($ident && $val);
	    $self->expect_keyword('}');
	}
	# read possible exceptPattern
	if ($self->read_controlword('-')){
	    print STDERR "Warning: USE OF EXCEPT PATTERN NOT IMPLEMENTED\n";
	    $self->Error('exceptPattern expected but not found') 
		unless $self->read_pattern($grammarPath, $grammarIdent, 
					   @parentElements);
	}
    }
    elsif ($self->read_keyword('external')){
	$self->begin_read_newfile;
	$self->read_pattern($grammarPath, $grammarIdent, @parentElements);
	$self->end_read_newfile;
    }
    elsif ($self->read_keyword('grammar')){
	my $ident = $DEF.$grammarCount++;
	$self->expect_keyword('{');
	$self->read_grammarContent($ident, @parentElements);
	$ident .= ':start';
	map(push(@{$self->{GRAPH}->{$DEF}->{$_}{REFS}}, 
		 $ident), @parentElements);
	$self->expect_keyword('}');
    }
    elsif ($self->read_keyword('parent')){
	my $ident = $self->read_identifier;
	if ($grammarPath =~ /^([.]+:)[^:]+$/){
	    $ident = $1.$ident;
	    map(push(@{$self->{GRAPH}->{$DEF}->{$_}{REFS}},
		     $ident), @parentElements);
	}
    }
    elsif ($self->read_keyword('empty') || $self->read_keyword('text')
	   || $self->read_keyword('notAllowed')){
	# do nothing
    }
    elsif (my $ident = $self->read_identifier){
	# check if we did not enter a grammar by mistake:
	my $asg = $self->read_assignMethod(1);
	if ($ident && $asg){
	    $self->put_back($ident.$asg);
	} else {
	    $ident = $grammarPath.':'.$ident;
	    map(push(@{$self->{GRAPH}->{$DEF}->{$_}{REFS}},
		     $ident), @parentElements);
	}
	
    } else { $found = 0; }
    
    if ($self->read_controlword('?') || $self->read_controlword('*')
	   || $self->read_controlword('+')){
	# ignore
    }
    
    if ($self->read_controlword(',') || $self->read_controlword('|')
	|| $self->read_controlword('&')){
	Error('Pattern expected') unless 
	    $self->read_pattern($grammarPath, $grammarIdent, @parentElements);
    }

    return $found;
}

sub read_assignMethod{
    my ($self, $asString) = @_;
    if ($asString){
	return '&=' if ($self->read_controlword('&='));
	return '|=' if ($self->read_controlword('|='));
	return '=' if ($self->read_controlword('='));
	return undef;
    } 
    return 3 if ($self->read_controlword('&='));
    return 2 if ($self->read_controlword('|='));
    return 1 if ($self->read_controlword('='));
    return 0;
}

# read a grammar pattern
sub read_grammarPattern{
    my ($self, $DEF, @parentElements) = @_;
    if ($self->read_keyword('grammar')){
	$self->expect_keyword('{');
	$self->read_grammarContent($DEF, @parentElements);
	$self->expect_keyword('}'); } 
    else{ 
	$self->read_grammarContent($DEF, @parentElements);}
}

# read all possible grammar contents 
sub read_grammarContent{
    my ($self, $DEF, @parentElements) = @_;
    my ($div, $found) = (0, 1);

    while ($found){
	if ($self->read_keyword('div')){
	    $div++;
	    $self->expect_keyword('{');
	    $self->read_grammarContent($DEF.':_G'.$div, @parentElements);
	    $self->expect_keyword('}');
	}
	elsif ($self->read_keyword('include')){
	    $self->begin_read_newfile;
	    $self->read_grammarPattern($DEF, @parentElements);
	    $self->end_read_newfile;
	    if ($self->read_controlword('{')){
		$self->read_grammarContent($DEF, @parentElements);
		$self->expect_keyword('}'); }
	} 
	elsif ($self->read_keyword('start')){
	    my $asg = $self->read_assignMethod;
	    $self->Error('Invalid assign method') unless $asg;
	    @{$self->{GRAPH}->{$DEF.':start'}->{PARENTS}} = @parentElements;
	    $self->read_pattern($DEF, 'start', @parentElements);
	}
	elsif (my $ident = $self->read_identifier('=\|\&')){
	    my $asg = $self->read_assignMethod;
	    $self->Error('Invalid assign method') unless $asg;
	    my $ref = $DEF.':'.$ident;
	    %{$self->{GRAPH}->{$ref}} = () if $asg == 1;
	    @{$self->{GRAPH}->{$ref}->{PARENTS}} = @parentElements;
	    $self->read_pattern($DEF, $ident, @parentElements);
	} 
	elsif ($self->ignore_annotation) {}
	else { $found = 0; }
    }
}

sub ns_prepend{
    my ($self, $tag, $ns_pref) = @_;
    my $ns = $ns_pref?$self->getNS($ns_pref):undef;
    $ns = $self->getNS('default') unless $ns;
    return "{$ns}:$tag";
}

# this should match the whole file
sub read_topLevel{
    my ($self) = @_;
    $self->read_decl;
    $self->read_pattern($DOCUMENT, 'start', $DOCUMENT);

    my ($after, $before) = (0, 1);
    while ($before != $after){
	$before = length($self->{DATA});
	$self->read_grammarContent($DOCUMENT, $DOCUMENT);
	$after = length($self->{DATA});
    }
    $self->{DATA} = trim($self->{DATA});
    $self->Error('Unable to completely process data') 
	unless $self->{DATA} eq '';
}

# remove leading and trailing white space
sub trim{
    my ($arg) = @_;
    $arg =~ s/^\s+//;
    $arg =~ s/\s+$//;
    return $arg;
}

sub build_info{
    my ($self) = @_;

    my %seen = ();
    local *go = sub {
	my ($reference, $node) = @_;
	
	my $ident = $reference.'#'.$node;
	return if defined $seen{$ident};
	$seen{$ident} = 1;

	map($self->{ATTR}->{$node}{$_} = 1, 
	    @{$self->{GRAPH}->{$reference}->{$node}{ATTRIBUTES}})
	    if defined $self->{GRAPH}->{$reference}->{$node}{ATTRIBUTES};
	
	my @sons;
	map(push(@sons, ($reference, $_)),
	    @{$self->{GRAPH}->{$reference}->{$node}{ELEMENTS}})
	    if defined $self->{GRAPH}->{$reference}->{$node}{ELEMENTS};
		
	if (defined $self->{GRAPH}->{$reference}->{$node}{REFS}){
	    my @refs = @{$self->{GRAPH}->{$reference}->{$node}{REFS}};
	    foreach my $ref(@refs){
		next unless $self->{GRAPH}->{$ref}->{PARENTS};
		foreach my $son(@{$self->{GRAPH}->{$ref}->{PARENTS}}){
		    map(push(@sons, ($ref, $_)),
			@{$self->{GRAPH}->{$ref}->{$son}{ELEMENTS}})
			if defined $self->{GRAPH}->{$ref}->{$son}{ELEMENTS};
		    push(@refs, @{$self->{GRAPH}->{$ref}->{$son}{REFS}})
			if defined $self->{GRAPH}->{$ref}->{$son}{REFS};
		    # if a reference has attributes defined,
                    # they will appear as attributes to $DOCUMENT
		    # if the reference is not defined within some element
		    map($self->{ATTR}->{$node}{$_} = 1,
			@{$self->{GRAPH}->{$ref}->{$son}{ATTRIBUTES}})
			if ($self->{GRAPH}->{$ref}->{$son}{ATTRIBUTES} && 
			    ($son eq $DOCUMENT));
		}
	    }
	}
	my $sonCount = ($#sons+1)/2;
	for (my $i = 0; $i < $sonCount; $i++){
	    my ($ref, $son) = ($sons[2*$i], $sons[2*$i+1]);
	    go($sons[2*$i], $sons[2*$i+1]);
	    $self->{NODES}->{$node}{$son} = 1;
	}
    };

    go($DOCUMENT.':start', $DOCUMENT);

    %seen = ();
    local *gnodes = sub {
	my ($node) = @_;
	return if $seen{$node};
	$seen{$node} = 1;
	foreach my $son(keys %{$self->{NODES}->{$node}}){
	    map($self->{GNODES}->{$node}{$_} = $son, 
		keys %{$self->{NODES}->{$son}});
	    gnodes($son); }
    };
    
    gnodes($DOCUMENT);
    @{$self->{TAGLIST}} = keys %seen;
}

sub getTagList {
    my ($self) = @_;
    return @{$self->{TAGLIST}};
}

sub tagChildren {
    my ($self, $tag) = @_;
    keys %{$self->{NODES}->{$tag}}; }

# given a tag and a childtag, return whether
# tag can contain childtag
sub canContain()
{
    my ($self, $tag, $childtag) = @_;  
    return ($self->{NODES}->{$tag}{$childtag} ||
	    $self->{NODES}->{$tag}{'*'})?1:0;
}

# there can be more results: list ?
# there can be no result, but a class of results.. like a nsName
# choose representative?
sub canContainIndirect()
{
    my ($self, $tag, $childtag) = @_; 
    return $self->{GNODES}->{$tag}{$childtag} if
	$self->{GNODES}->{$tag}{$childtag};

    if ($self->{NODES}->{$tag}{'*'}){
	foreach (@{$self->{TAGLIST}}){
	    return $_ if $self->{NODES}->{$_}{$childtag};
	}
    }
}

# given a tag and an attribute return whether 
# the tag can have that attribute 
sub canHaveAttribute()
{
    my ($self, $tag, $attr) = @_;
    return ($self->{ATTR}->{$tag}{$attr} ||
	    $self->{ATTR}->{$tag}{'*'})?1:0;
}

sub canContainSomehow()
{
    my ($self, $tag, $childtag) = @_; 
    return ($self->canContain($tag, $childtag) || 
	    $self->canContainIndirect($tag, $childtag));
}

1;
