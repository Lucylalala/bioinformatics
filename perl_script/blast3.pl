#!/usr/bin/perl -w 

use strict;

my $beginning_annotation = '';
my $ending_annotation = '';
my %alignments = ();
my $alignment = '';
my $filename = '/Users/lushan/Desktop/perl_script/blast1.txt';
my @HSPs = ();
my ( $expect, $query, $query_range, $subject, $subject_range, $score, $identities ) =
( '', '', '', '', '', '', '' );

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