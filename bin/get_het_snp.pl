use strict;
use warnings;

my ($eas,$infile,$outfile) = @ARGV;

# read EAS SNP file (1-based)
# /data1/software/annovar/humandb/hg19_EAS.sites.2014_10.txt

my %snp;
open IN, "$eas" or die;
while (<IN>){
	chomp;
	my @arr = split /\t/;
	my $ref_len = length($arr[2]);
	my $alt_len = length($arr[3]);
	
	if ($ref_len != 1 or $alt_len != 1){
		next; # skip
	}

	$snp{$arr[0]}{$arr[1]} = $_; # chr=>pos=>line_value
}
close IN;


# output het pos
# cutoff is: [0.4,0.6]
open O, ">$outfile" or die;
open IN, "$infile" or die;
my $h = <IN>;
print O "$h";

while (<IN>){
	chomp;
	my @arr = split /\t/;
	if (exists $snp{$arr[0]}{$arr[1]}){
		if ($arr[-1] >= 0.4 and $arr[-1] <= 0.6){
			# a het pos
			print O "$_\n";
		}
	}
}
close IN;
close O;

