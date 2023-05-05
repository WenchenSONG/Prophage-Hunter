#!/usr/bin/perl -w

die ("Argument error!") if (@ARGV!=2);
open (R_1,"< $ARGV[0]") || die ("Cannot open $ARGV[0]: $!\n");
open (W_1,"> $ARGV[1]");

select W_1;

if ($ARGV[1]=~/(.+?)\.stats\.txt/) {
	$sample=$1;
}

while ($_=<R_1>) {
	if ($_=~/^ID\tSeq\t(.+?)\n/) {
		print "Sample"."\t".$1."\n";
	}
	else {
		chomp($_);
		@array_1=split(/\t/,$_);
		for ($i=2;$i<=$#array_1;$i++) {
			$hash_1{$i}+=$array_1[$i];
		}
	}
}

for ($i=2;$i<=$#array_1;$i++) {
	$tmp.=$hash_1{$i}."\t";
}

chop($tmp);
print $sample."\t".$tmp."\n";
$tmp="";

for ($i=2;$i<=$#array_1;$i++) {
	$a=$hash_1{$i}/$hash_1{$#array_1};
	$tmp.=$a."\t";
}

chop($tmp);
print $sample."(%)\t".$tmp."\n";

close R_1;
close W_1;
