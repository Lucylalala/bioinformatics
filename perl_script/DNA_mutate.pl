#!/usr/bin/perl -w
use strict;
use BeginPerlBioinfo;

my $DNA = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
my $i;
my $mutant;

srand( time | $$ );

$mutant = mutate_better($DNA);

print "\nMutate DNA\n\n";

print "\nHere is the original DNA:\n\n";
print "$DNA\n";

print "\nHere is the mutant DNA:\n\n";
print "$mutant\n";

# Let's put it in a loop and watch that bad boy accumulate mutations:
print "\nHere are 10 more successive mutations:\n\n";

for ( $i = 0 ; $i < 10 ; ++$i ) {
$mutant = mutate($mutant);
print "$mutant\n";
}

exit

