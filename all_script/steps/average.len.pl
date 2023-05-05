#!/usr/bin/perl -w

die ("Argument error!") if (@ARGV!=3);
open (R_1,"< $ARGV[0]") || die ("Cannot open $ARGV[0]: $!\n"); # prophage
open (R_2,"< $ARGV[1]") || die ("Cannot open $ARGV[1]: $!\n"); # host
open (W_1,"> $ARGV[2]");

select W_1;

($sum,$count)=(0,0);

while ($_=<R_1>) {
	if ($_=~/^.+?\t(.+?)\n/) {
		$sum+=$1;
		$count++;
	}
}

$average_1=$sum/$count;

print $average_1."\t";

($sum,$count)=(0,0);

while ($_=<R_2>) {
	if ($_=~/^.+?\t(.+?)\n/) {
		$sum+=$1;
		$count++;
	}
}

$average_2=$sum/$count;

print $average_2."\t";

$FC=$average_1/$average_2; # prophage/host

print $FC."\n";

close R_1;
close W_1;
