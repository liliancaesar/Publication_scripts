#!/usr/bin/perl
## Pombert lab 2018
## Uses the output of RNAseq mapping, samtools, and EMBL annotations to identify which genes are expressed
my $version = "v0.2 Lilian";

use strict;
use warnings;
use Getopt::Long qw(GetOptions);

my $usage = <<"OPTIONS";
VERSION		$version
SYNOPSIS	Calculates average RNAseq depth per genes from samtools depth files and NCBI gff annotations files
USAGE		genes_expressed.pl -c PASS.coverage -o expressed_proteins.tsv -g *.gff
-c	Coverage file obtained with Samtools # samtools depth -aa PASS_sorted.bam > PASS.coverage
-p	Product list (tab-delimited)
-o	Output file in TSV format [Default = expressed_proteins.tsv]
-g	Annotations (in GFF format)
OPTIONS

die "$usage" unless @ARGV;

my $coverage;
my @gff;
my $output = 'expressed_proteins.tsv';
GetOptions(
	'c=s'=>\$coverage,
	'o=s'=>\$output,
	'g=s@{1,}'=>\@gff
);


## Creating coverage database
open COV, "<$coverage" or die "Can't open $coverage!\n";
my %coverage;
system "echo Working on coverage database...";
while (my $line = <COV>){
	chomp $line;
	if ($line =~ /^(\S+)\t(\d+)\t(\d+)/){
		my $contig = $1; #print "$contig\t";
		my $position = $2; #print "$position\t";
		my $cov = $3; #print "$cov\n";
		$coverage{$contig}{$position} = $cov;
	}
}

## Working through CDS annotations; disregarding tRNA and rRNAs...
system "echo Working on GFF files...";
open OUT, ">$output";
print OUT "Protein\tProduct\tSum\tLength (in nt)\tAverage RNAseq depth\n";
my $sum; my $size; my $average; my $cg; my $locus_tag; my $product;
my %products; my %exons;
my $left; my $right;
while (my $gff = shift@gff){
	open GFF, "<$gff";
	while (my $line = <GFF>){
		chomp $line;
		$sum = 0; $size = 0; $average = 0;
		if ($line =~ /^#/){next;}
		elsif ($line =~ /^(\S+).*Genbank\sgene.*locus_tag=(\w+)/){
			$cg = $1; $locus_tag = $2;
		}
		elsif ($line =~ /^(\S+).*Genbank\sCDS\s(\d+)\s+(\d+).*;product=(.*?);/){
			$cg = $1;
			$left = $2;
			$right= $3;
			$product = $4;
			$products{$locus_tag}[0] = $product;
			$products{$locus_tag}[1] = $cg;
			push (@{$exons{$locus_tag}}, "$left\t$right");
		}
	}
}

for my $tag (keys %products){
	while (my $nt = shift@{$exons{$tag}}){
		my ($start, $end) = split ("\t", $nt);
		for my $pos ($start..$end){
			$sum += "$coverage{$products{$tag}[1]}{$pos}";
			$size++;
		}
	}
	$average = sprintf ("%.2f", $sum/$size); # unless $size == 0;
	print OUT "$tag\t$products{$tag}[0]\t$sum\t$size\t$average\n";
	$sum = 0; $size = 0; $average = 0;
}