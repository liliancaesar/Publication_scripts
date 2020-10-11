#!/usr/bin/perl
## Lilian Caesar (lica.caesar@gmail.com), Pombert Lab 2019. 

my $version = '0.2';

use strict; 
use warnings;

## Option definitions
my $usage = <<"OPTIONS";
VERSION = $version
SYNOPSIS = this script will return genes differentially expressed from transcriptomes without replicates, meaning 2 datasets from diseased bees and 1 from healthy bees.
USAGE = genes_diff_expr.pl aerx123_norm.tsv
OPTIONS
die "\n$usage\n" unless @ARGV;

## Opening input and output files from the command line
open IN, "<$ARGV[0]"; #columns input file: gene [0], product [1], depth normalized sample A [2], depth normalized sample B [3],  depth normalized sample C [4] (first row with titles removed)
$ARGV[0] =~ s/.tsv$//;
open OUT, ">$ARGV[0].DEGs.tsv"; #columns input file: gene [0], product [1], gene differently expresses between healthy and unhealthy [2]

my $totalprot =0;
my $protdiff13 = 0;
my $protdiff123 = 0;

while (my $line = <IN>){
	chomp $line;
	$totalprot++;
	my @columns = split("\t", $line);
	my $S1 = $columns[2];
	my $S2 = $columns[3];
	my $S3 = $columns[4];
	my $max13;
	my $max23;
	my $diff13;
	my $diff23;
	if (($S1 >20) || ($S3 >20)){ #at least 20x for one of the sample-gene
		if ($S1 >= $S3) {$max13 = $S1} #to use the highest value for next formula
		else {$max13 = $S3}
		my $diff13 = (($S1+$S3)/($max13+$max13))*100; #formula to extract DEGs
		if ($diff13 <= 70) {
			$protdiff13++;
			if (($S2 >20) || ($S3 >20)){
				if ($S2 >= $S3) {$max23 = $S2} #to use the highest number for next divisions
				else {$max23 = $S3}
				my $diff23 = (($S2+$S3)/($max23+$max23))*100; #formula to extract DEGs
				if ($diff23 <= 70) {
				$protdiff123++;
				print OUT "$columns[0]\t$columns[1]\t$columns[2]\t$columns[3]\t$columns[4]\t$diff13\t$diff23\n";
				}
			}
		}
	}
}
print "Done\n";