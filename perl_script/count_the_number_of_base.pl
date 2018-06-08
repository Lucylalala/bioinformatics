#!/usr/bin/perl -w

use strict;

my ($USAGE) = "no DNA inputs\n\n";
my (@sequence) = "asdasfsfafsdfdggfggfg";
unless (@sequence) {
	print $USAGE;
	exit;
}

my($dna) = $sequence[0];
my ($num_of_Gs) = countG($dna); 
print "\nThe DNA $dna has $num_of_Gs G\'s in it!\n\n";
exit;

sub countG
{
	my ($dna) = @_;
	my ($count) = 0;
	$count = ($dna =~ tr/Gg//);
	return $count;
}
