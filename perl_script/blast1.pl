#!/usr/bin/perl -w 
# Example 12-1 Extract annotation and alignments from BLAST output file

use strict;
use warnings;
use BeginPerlBioinfo; # see Chapter 6 about this module

# declare and initialize variables
my $beginning_annotation = '';
my $ending_annotation = '';
my %alignments = ();
my $filename = '/Users/lushan/Desktop/perl_script/blast.txt';

parse_blast( \$beginning_annotation, \$ending_annotation, \%alignments,
$filename );

# Print the annotation, and then
# print the DNA in new format just to check if we got it okay.
print $beginning_annotation;

foreach my $key ( keys %alignments ) {
print "$key\nXXXXXXXXXXXX\n", $alignments{$key}, "\nXXXXXXXXXXX\n";
}

print $ending_annotation;
exit;
