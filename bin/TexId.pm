# package for handling .tex IDs

package TexId;

use File::Basename;
use strict;

# error messages markers

use constant ERR  => '[X]'; # error can't be fixed

################### 'public' members ################### 

sub new{
    my ($class, %options) = @_;
    my $self = {};

    @{$self->{ENVIRONMENTS}} = qw(module note omtext example 
				  definition problem proof 
				  solution program);    # the environments to look at

    @{$self->{ENV_PREFIXES}} = qw(mod not txt ex def prob pf sol prg);    # the prefixes for environments
    
    
    @{$self->{ENV_DEF}} = qw(id);    # environment arguments that define new environments
    @{$self->{ENV_USAGE}} = qw(use uses for from);    # environment arguments that 
                                                      # specify usage of other environments

    # options for the class
    %{$self->{OPTIONS}} = %options;

    # in case \snippath{} is encountered, prepend this to the filename
    $self->{OPTIONS}{snippath} = 'snippets/' unless defined $self->{OPTIONS}{snippath};


    # show progress while reading data
    $self->{OPTIONS}{progress} = 1 unless defined $self->{OPTIONS}{progress};
    
    bless ($self, $class);
}

# check/set list of environments to look at
sub environments{
    my ($self, $new_environments, $new_prefixes) = @_;
    if (defined $new_environments and defined $new_prefixes){
	@{$self->{ENVIRONMENTS}} = split(/,/, $new_environments);
	@{$self->{ENV_PREFIXES}} = split(/,/, $new_prefixes);
	die "Invalid argument combination (both arguments must have same number of elements)" 
	    if $#{$self->ENVIRONMENTS} != $#{$self->ENV_PREFIXES};
    }
    else {
	return (join(',', @{$self->{ENVIRONMENTS}}), join(',', @{$self->{ENV_PREFIXES}}));
    }
}

# define/read environment definition arguments
sub env_def{
    my ($self, $new_env_def) = @_;
    if (defined $new_env_def){
	@{$self->{ENV_DEF}} = split(/,/, $new_env_def);
    }
    else {
	return join(',', @{$self->{ENV_DEF}});
    }
}

# define/read the environment usage arguments
sub env_usage{
    my ($self, $new_env_usage) = @_;
    if (defined $new_env_usage){
	@{$self->{ENV_USAGE}} = split(/,/, $new_env_usage);
    }
    else {
	return join(',', @{$self->{ENV_USAGE}});
    }
}

# define/read the snippets path
sub snippath{
    my ($self, $new_snippath) = @_;
    if (defined $new_snippath){
	$new_snippath.='/' if ($new_snippath !~ /\/$/);
	$self->{OPTIONS}{snippath} = $new_snippath;
    }
    else {
	return $self->{OPTIONS}{snippath};
    }
}


# check all the definitions and module usages 
# in all files referenced by base file
sub parse{

    my ($self, $basefile) = @_;
    
    # recursive local function to go through each file
    local *run_parse = sub
    {
	my ($filename) = @_;
	
	# read current .tex file
	print STDERR "Loading $filename...\n" if ($self->{OPTIONS}{progress} == 1);
	$filename = $self->load_file_data($filename);
	my @text = @{$self->{FILEDATA}};    
	my $line_no = 0;

	# go through every line of the read file
	# depends on: \requiremodules, \snippath
	# ignores \end{document}

	foreach (@text){
	    # delete newline character, comments and redundant white space

	    $line_no++;
	    /([^%]*)((%.*)?)/;
	    $_ = $1;
	    s/\s+//g;

	    # see if an environment that has some arguments is defined
	    my ($possible_env, $env_args) = (undef, undef);
	    ($possible_env, $env_args) = ($1, $2) if (/\\begin\{([^\}]+)\}\[([^\]]+)\]/);
	    
	    # if it is, search it through the list of environments we want to look at
	    if (defined $possible_env){
		foreach my $environment(@{$self->{ENVIRONMENTS}}){
		    next unless ($environment eq $possible_env);
		    
		    # if we found an anvironment we want to look at,
		    # go through the list of arguments
		    $env_args = $self->swap_exterior_char(',', ';', $env_args);
		    foreach (split(/;/, $env_args)){
			# we want arguments of type name=value
			next unless /([^=]+)=(.+)/;
			my ($arg_name, $arg_value) = ($1, $2);
			
			# see if the argument defines an environment
			foreach my $current_env_arg(@{$self->{ENV_DEF}}){
			    next unless ($arg_name eq $current_env_arg);
			    my @to_add = split(/,/, $arg_value);
			    push(@{$self->{'DEF'}->{$environment}}, @to_add);
			    foreach my $added_element(@to_add){
				$self->{'DEF'}->{LOCATION}{$added_element}.=$line_no.':'.$filename."\n";
			    }
			    last;
			}
			
			# see if the argument uses an environment
			foreach my $current_env_arg(@{$self->{ENV_USAGE}}){
			    next unless ($arg_name eq $current_env_arg);
			    my @to_add = split(/,/, $arg_value);
			    push(@{$self->{'USE'}->{$environment}}, @to_add);
			    foreach my $added_element(@to_add){
				$self->{'USE'}->{LOCATION}{$added_element}.=$line_no.':'.$filename."\n";
			    }
			    last;
			}
		    }
		    last;
		}
	    }
	    # reference to another file
	    if (/\\requiremodules(\[(include|exclude)\])?\{([^\}]+)\}/){
		if (defined $2 && $2 eq 'include'){
		    $_ = $3;
		    $_ = $self->{OPTIONS}{snippath}.$1 if (/\\snippath\{(.+)/);
		    $_ = $self->{path}.$_;
		    run_parse($_);
		}
	    }

	    # see definition of snippath
	    $self->snippath($1) if (/\\def\\snippath\#1\{([^\#]+)\#1\}$/);
	}
    };

    run_parse($basefile);

}

# this is the first checking step to be done
sub check_uniq{
    
    my ($self) = @_;
    
    my $error = 0;
    
    # sort environment definitions and see whether they are uniquely defined
    foreach my $environment(@{$self->{ENVIRONMENTS}}){
	next unless defined $self->{'USE'}->{$environment};
	
	my @list1 = sort @{$self->{'DEF'}->{$environment}};
	my @list2 = $self->uniq(@list1);
	@{$self->{'DEF'}->{$environment}} = @list2;
	
	# some environments are defined multiple times
	if ($#list1 != $#list2){
	    my $j = 0;
	    for (my $i = 0; $i<=$#list2; $i++){
		my $start_j = $j;
		while ($j<=$#list1 && $list1[$j] eq $list2[$i]){
		    $j++;
		}
		if ($j - $start_j != 1){
		    print STDERR ERR, " Environment '$list2[$i]' is defined multiple times ",
		    "within same environment type: \n";
		    print STDERR $self->{'DEF'}->{LOCATION}{$list2[$i]}, "\n";
		    $error = 1;
		}
	    }
	}
    }
   
    # see that all environment references are unique (and sort them)
    foreach my $environment(@{$self->{ENVIRONMENTS}}){
	next unless defined $self->{'USE'}->{$environment};
	@{$self->{'USE'}->{$environment}} = sort $self->uniq(@{$self->{'USE'}->{$environment}});
    }
    
    return $error;
}

sub check_prefix{

    my ($self) = @_;

    my $count = $#{$self->{ENVIRONMENTS}}+1;
    
    for (my $i = 0; $i < $count; $i++){
	my $environment = ${$self->{ENVIRONMENTS}}[$i];
	my $envprefix = ${$self->{ENV_PREFIXES}}[$i];
	next unless defined $self->{'DEF'}->{$environment};
	
	foreach my $elem (@{$self->{'DEF'}->{$environment}}){
	    
	    my $proper = undef;
	    if ($elem =~ /^([^:]+):(.+)/){
		$proper = $envprefix.':'.$2 if $1 ne $envprefix;
	    } else {
		$proper = $envprefix.':'.$elem;
	    }
	    
	    if (defined $proper){
		print STDERR ERR, " $environment '$elem' has no prefix ($envprefix). Add it? [ <y>, n ]";
		my $answer = <STDIN>;
		chomp($answer);
		if ($answer eq 'y' or $answer eq ''){
		    $self->add_change('DEF', $elem, $proper);
		}
	    }
	}
    }
}


sub check_defs{
    my ($self) = @_;

    my $error = 0;

    # combine all definitions
    my @defs;
    map {push(@defs, @{$self->{'DEF'}->{$_}}) if defined @{$self->{'DEF'}->{$_}}} @{$self->{ENVIRONMENTS}};
    @defs = sort @defs;

    # combine all used environments
    my @uses;
    map {push(@uses, @{$self->{'USE'}->{$_}}) if defined @{$self->{'USE'}->{$_}}} @{$self->{ENVIRONMENTS}};
    @uses = sort @uses;


    # for all environments
    
    foreach my $used_env(@uses){
	# if used environment is not defined
	if ($self->find_elem($used_env, @defs) < 0){
	    # maybe it is a typo
	    print STDERR ERR, " '$used_env' was not found. Replace options:\n";
	    foreach my $definition(@defs){
		print STDERR "\t$definition\n" if $self->edit_dist($used_env,$definition)<4;
		$error = 1;
	    }
	}
    }

    return $error;
}


sub add_change{
    my ($self, $location, $from, $to) = @_;
    if ($self->{$location}->{LOCATION}{$from} =~ /([^:]+):([^\n]+)\n/){
	push(@{$self->{CHANGE}->{$2}}, ($1, $from, $to));
    }
}

# write the stored changes
sub apply_changes{
    my ($self) = @_;
    while (my ($filename, $changes) = each %{$self->{CHANGE}}){
	$filename = $self->load_file_data($filename);
	my $count = int(($#{$changes}+1)/3);
	for (my $i = 0; $i<$count ; $i++){
	    my ($line, $from, $to) = (${$changes}[$i*3]-1,
				      ${$changes}[$i*3+1], ${$changes}[$i*3+2]);
	    ${$self->{FILEDATA}}[$line] =~ s/\Q$from/$to/;
	}
	print STDERR "Writing $filename\n" if ($self->{OPTIONS}{progress} == 1);
	$self->write_file_data($filename);       
    }
}

sub load_file_data{
    my ($self, $filename) = @_;

    # try to give proper file extension if file is not found
    $filename = $self->add_ext($self->drop_ext($filename)) unless -e $filename;
    
    open(FIN, $filename) or die "Cannot open $filename\n";
    @{$self->{FILEDATA}} = <FIN>;    
    close(FIN);
    
    $self->{path} = dirname($filename).'/' unless defined $self->{path};

    return $filename;
}

sub write_file_data{
    my ($self, $filename) = @_;

    open(FOUT, ">$filename") or die "Cannot write $filename\n";
    print FOUT @{$self->{FILEDATA}};
    close(FOUT);
}


################### 'protected' members ################### 

sub def_env_list{
    my ($self, $env_name) = @_;
    return @{$self->{'DEF'}->{$env_name}};
}

sub use_env_list{
    my ($self, $env_name) = @_;
    return @{$self->{'USE'}->{$env_name}};
}


################### 'private' members ################### 

sub drop_ext{
    my ($self, $filename) = @_;
    while ($filename =~ /\.tex$/){
	while ($filename !~ /\.$/ ) { chop($filename); }
	chop($filename);
    }
    return $filename;
}

sub add_ext{
    my ($self, $filename) = @_;
    $filename.='.tex' if $filename !~ /\.tex$/;
    return $filename;
}

# look at $word, and swap all occurances of $char_find with 
# $new_char if they are not in a {...}  environment

sub swap_exterior_char{
    my ($self, $char_find, $new_char, $word) = @_;
    my @new_word = ();
    my $exterior = 0;
    foreach (split('', $word)){
	if ($_ eq '{'){
	    $exterior++;
	    next;
	}
	
	if ($_ eq '}'){
	    $exterior--;
	    next;
	}
	
	if ($exterior == 0 && $_ eq $char_find){
	    push(@new_word, $new_char);
	}
	else{
	    push(@new_word, $_);
	}
    }
    return join('',@new_word);	
}

# return unique elements from a list
sub uniq{
    my ($self, @list) = @_;
    my %seen = ();
    my @uniqu = grep { ! $seen{$_} ++ } @list;
    return @uniqu;
}


# binary search
sub find_elem{
    my ($self, $elem, @list) = @_;
    
    local *search_elem = sub
    {
	my ($a, $b) = @_;
	my $m = int(($a + $b)/2);
	return $m if $list[$m] eq $elem;
	return -1 if ($a >= $b);
	return ($list[$m] le $elem)?search_elem($m+1,$b):search_elem($a,$m-1);
    };

    return search_elem(0, $#list);
}

# edit distance between two strings
# insertions, deletions, replacement, transposition
sub edit_dist{
    my ($self, $s1, $s2) = @_;
    my $m = length($s1);
    my $n = length($s2);
    my @w1 = split(//, $s1);
    my @w2 = split(//, $s2);

    # add dummy char so we can have nicer indeces 
    unshift(@w1, '*');
    unshift(@w2, '*');

    # distances matrix
    my @d;

    # initialize
    $d[0][0] = 0;
    for (my $i = 1; $i <= $m ; $i++) { $d[$i][0] = $i;}
    for (my $i = 1; $i <= $n ; $i++) { $d[0][$i] = $i;}
    
    # compute
    for (my $i = 1; $i <= $m ; $i++){
	for (my $j = 1; $j <= $n ; $j++){
	    my @possibilities = ($d[$i-1][$j-1] + ($w1[$i] ne $w2[$j]),
				 $d[$i-1][$j] + 1, $d[$i][$j-1] + 1);
	    
	    push(@possibilities, $d[$i-2][$j-2] + 1)
		if ($i>1 && $j>1 && $w1[$i] eq $w2[$j-1] && $w1[$i-1] eq $w2[$j]);
	    
	    $d[$i][$j] = $self->minimum(@possibilities);
	}
    }
    return $d[$m][$n];
}

sub minimum{
    my ($self, @list) = @_;
    my $result = shift(@list);
    map {$result = $_ if $result ge $_} @list;
    return $result;
}


1;
