#!/usr/bin/perl

print "Running...\n";

use Text::CSV_XS;

$randomoutputtxt11 = '/home/control-io/www/notarealfile';

my $csv = Text::CSV_XS->new ({ binary => 1, auto_diag => 1});
# open my $fh, "< $randomoutputtxt11" or exit "$randomoutputtxt11: $!";
open my $fh, "< $randomoutputtxt11";
my $msoluser_data = '';
my $msol_type = '';

while (my $row = $csv->getline ($fh)) {

    print "I: $row->[0]\n";    
    
}
close $fh;


print "Made it to the end!\n";
