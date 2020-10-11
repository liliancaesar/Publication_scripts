#!/usr/bin/perl
## Lilian Caesar (lica.caesar@gmail.com), Pombert Lab 2019. 
my $version = '0.2';

use strict; use warnings;

## Option definitions
my $usage = <<"OPTIONS";
VERSION = $version
SYNOPSIS = this script normalizes gene depth, a step before the recovery of differently expressed genes.
USAGE = normalization.pl file.tsv multiplier
OPTIONS
die "\n$usage\n" unless @ARGV;

## Opening input and output files from the command
open IN, "<$ARGV[0]"; #outputs from the script "gene_expression.pl"
$ARGV[0] =~ s/.tsv$//;
open OUT, ">$ARGV[0].norm.tsv";

## Working on input file
while (my $line = <IN>){
	chomp $line; 
	my @columns = split("\t", $line);	#split columns from my input and save as separete elements in my array @columns
	my $depth = $columns[4];
	if ($depth =~ /\d$/){ #if the information of fifth column finish with a number go forward
		my $normvalue = $depth*$ARGV[1];  #ARGV[1] is the the result of '100000000/total number of reads'
	} 
	print OUT join ("\t", @columns); #print undoing the split but keeping the columns separated by tab
	print OUT "\n";
}
print "done!\n";