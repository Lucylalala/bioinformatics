#!/usr/bin/perl -w 

use strict;

my $beginning_annotation = '';
my $ending_annotation = '';
my %alignments = ();
my $alignment = '';
my $filename = '/Users/lushan/Desktop/perl_script/blast.txt';
my @HSPs = ();
my ($local, $score, $expect, $identities, $query, $query_range, $subject, $subject_range ) =
( '', '', '', '', '', '', '' );

parse_blast( \$beginning_annotation, \$ending_annotation, \%alignments,
$filename );

$alignment = $alignments{'hmm11616054'};

@HSPs = parse_blast_alignment_HSP($alignment);

(  $score, $expect, $identities, $query, $query_range, $subject, $subject_range ) =
extract_HSP_information( $HSPs[1] );

# Print the results
print "\n-> Score value: $score\n";
print "\n-> Expect value: $expect\n";
print "\n-> Identities value: $identities\n";
print "\n-> Query string: $query\n";
print "\n-> Query range: $query_range\n";
print "\n-> Subject String: $subject\n";
print "\n-> Subject range: $subject_range\n";

exit;



sub parse_blast {

    my($beginning_annotation, $ending_annotation, $alignments, $filename) = @_;

    # $beginning_annotation-reference to scalar
    # $ending_annotation   -reference to scalar
    # $alignments          -reference to hash
    # $filename            -scalar
    
    # declare and initialize variables
    my $blast_output_file = '';
    my $alignment_section = '';
    
    # Get the BLAST program output into an array from a file
    $blast_output_file = join( '', get_file_data($filename));

    # Extract the beginning annotation, alignments, and ending annotation
    ($$beginning_annotation, $alignment_section, $$ending_annotation)
    = ($blast_output_file =~ /(.*^ALIGNMENTS\n)(.*)(^  Database:.*)/ms);
    
    # Populate %alignments hash
    # key = ID of hit
    # value = alignment section
    %$alignments = parse_blast_alignment($alignment_section);
}

sub parse_blast_alignment_HSP {

    my($alignment ) = @_;

    # declare and initialize variables
    my $beginning_annotation  = '';
    my $HSP_section  = '';
    my @HSPs = (  );
    
    # Extract the beginning annotation and HSPs
    ($beginning_annotation, $HSP_section )
        = ($alignment =~ /(.*?)(^ Score =.*)/ms);

    # Store the $beginning_annotation as the first entry in @HSPs
    push(@HSPs, $beginning_annotation);

    # Parse the HSPs, store each HSP as an element in @HSPs
    while($HSP_section =~ /(^ Score =.*\n)(^(?! Score =).*\n)+/gm) {
        push(@HSPs, $&);
    }

    # Return an array with first element = the beginning annotation,
    # and each successive element = an HSP
    return(@HSPs);
}

sub extract_HSP_information {

    my($HSP) = @_;
    
    # declare and initialize variables
    my($score) = '';
    my($expect) = '';
    my($identities) = '';
    my($query) = '';
    my($query_range) = '';
    my($subject) = '';
    my($subject_range) = '';
    
    ($score) = ($HSP =~ /Score = (\S+)/);
    
    ($expect) = ($HSP =~ /Expect = (\S+)/);

    ($identities) = ($HSP =~ /Identities = (\S+)/);

    $query = join ( '' , ($HSP =~ /^Query.*\n/gm) );

    $subject = join ( '' , ($HSP =~ /^Sbjct.*\n/gm) );

    $query_range = join('..', ($query =~ /(\d+).*\D(\d+)/s));

    $subject_range = join('..', ($subject =~ /(\d+).*\D(\d+)/s));

    $query =~ s/[^acgt]//g;

    $subject =~ s/[^acgt]//g;

    return ( $score, $expect, $identities, $query, $query_range, $subject, $subject_range);
}

sub get_file_data {

    my($filename) = @_;

    use strict;
    use warnings;

    # Initialize variables
    my @filedata = (  );

    unless( open(GET_FILE_DATA, $filename) ) {
        print STDERR "Cannot open file \"$filename\"\n\n";
        exit;
    }

    @filedata = <GET_FILE_DATA>;

    close GET_FILE_DATA;

    return @filedata;
}

sub parse_blast_alignment {

    my($alignment_section) = @_;
    
    # declare and initialize variables
    my(%alignment_hash) = (  );

    # loop through the scalar containing the BLAST alignments,
    # extracting the ID and the alignment and storing in a hash
    #
    # The regular expression matches a line beginning with >,
    # and containing the ID between the first pair of | characters;
    # followed by any number of lines that don't begin with >

    while($alignment_section =~ /^>.*\n(^(?!>).*\n)+/gm) {
        my($value) = $&;
        my($key) = (split(/\|/, $value)) [1];
        $alignment_hash{$key} = $value;
    }

    return %alignment_hash;
}
