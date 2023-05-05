#!/usr/bin/perl -w

$file_list=readpipe("ls ../Step4.Calculating_PL_TO_AAC/PL.Candidate_*.txt | cat");

###################### PL #######################

while ($file_list=~/(Candidate_\d+).txt\n/g) {
	$input_file_name="../Step4.Calculating_PL_TO_AAC/PL.".$1.".txt";
	$PL=readpipe("cut -f1 $input_file_name");
	chomp($PL);
	$hash_PL{$1}=$PL;
}


###################### TO #######################

while ($file_list=~/(Candidate_\d+).txt\n/g) {
	$input_file_name="../Step4.Calculating_PL_TO_AAC/TO.".$1.".txt";
	$TO=readpipe("cut -f1 $input_file_name");
	chomp($TO);
	$hash_TO{$1}=$TO;
}

###################### AA #######################

while ($file_list=~/(Candidate_\d+).txt\n/g) {
	$input_file_name="../Step4.Calculating_PL_TO_AAC/".$1.".stats.txt";
	$AA=readpipe("tail -n 1 $input_file_name | cut -f2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21");
	chomp($AA);
	$hash_AA{$1}=$AA;
}

###################### TO.NEW.1 (strand.pl) #######################

while ($file_list=~/(Candidate_\d+).txt\n/g) {
	$input_file_name="../Step4.Calculating_PL_TO_AAC/".$1.".strand.txt";
	$tmp=$1;
	open (R_1,"< $input_file_name") || die ("Cannot open $input_file_name: $!\n");
	while ($_=<R_1>) {
		if ($_=~/^\+\n/) {
			$plus++;
		}
		elsif ($_=~/^\-\n/) {
			$minus++;
		}
	}
	$ratio=($plus+1)/($minus+1);
	if ($ratio<1) {
		$ratio=1/$ratio;
	}
	$hash_TONEW1{$tmp}=$ratio;
	$plus=0;
	$minus=0;
}

close R_1;

###################### TO.NEW.2 (ATOS) #######################

while ($file_list=~/(Candidate_\d+).txt\n/g) {
	$input_file_name_1="../Step4.Calculating_PL_TO_AAC/".$1.".strand.txt";
	$input_file_name_2="../Step4.Calculating_PL_TO_AAC/".$1.".results.txt";
	$value1=readpipe("wc -l $input_file_name_1 | cut -f1 -d \" \"");
	$value2=readpipe("wc -l $input_file_name_2 | cut -f1 -d \" \"");
	$ATOS=$value1/$value2;
	$hash_TONEW2{$1}=$ATOS;
}

###################### FINAL output ###########################

open (W_1,"> 24.txt");
select W_1;

print "Candidate_ID"."\t"."PL"."\t"."TO"."\t"."A"."\t"."R"."\t"."N"."\t"."D"."\t"."C"."\t"."Q"."\t"."E"."\t"."G"."\t"."H"."\t"."I"."\t"."L"."\t"."K"."\t"."M"."\t"."F"."\t"."P"."\t"."S"."\t"."T"."\t"."W"."\t"."Y"."\t"."V"."\t"."TO.NEW.1"."\t"."TO.NEW.2"."\n";

while (($key,$value)=each(%hash_PL)) {
	print $key."\t".$value."\t".$hash_TO{$key}."\t".$hash_AA{$key}."\t".$hash_TONEW1{$key}."\t".$hash_TONEW2{$key}."\n";
}

close W_1;

