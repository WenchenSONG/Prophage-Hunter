#!/usr/bin/perl -w

#die ("Argument error!") if (@ARGV!=1);
open (R_1,"< Marker.txt") || die ("Cannot open Marker.txt: $!\n"); # Marker.txt ---- iprscan
open (R_2,"< out.outfmt6.uniq.txt") || die ("Cannot open out.outfmt6.uniq.txt: $!\n"); # out.outfmt6.uniq.txt ---- blast
open (R_3,"< Candidate_all.seq.Len.txt") || die ("Cannot open Candidate_all.seq.Len.txt: $!\n"); # Candidate_all.seq.Len.txt
open (R_4,"< gene_list.txt") || die ("Cannot open gene_list.txt: $!\n"); # gene_list.txt
open (W_1,"> Annotation_all.txt");

select W_1;

while ($_=<R_1>) {
	if ($_=~/^(.+?)\t(.+?\t.+?)\t.+?\n/) {
		$hash_1{$1}=$2;
	}
}

while ($_=<R_2>) {
	@array_1=split(/\t/,$_);
	($gene_id,$tmp)=($array_1[0],$array_1[18]);
	if ($tmp=~/^.+?\s+(.+?)\s+\[/) {
		$nr=$1;
		$hash_2{$gene_id}=$nr;
	}
}

while ($_=<R_3>) {
	if ($_=~/^(.+?)\t(.+?)\n/) {
		$hash_3{$1}=$2;
	}
}

while ($_=<R_4>) {
	chomp($_);
	print $_."\t".$hash_3{$_}."\t";
	if (exists $hash_2{$_}) {
		print $hash_2{$_}."\t";
	}
	else {
		print "#N/A"."\t";
	}
	if (exists $hash_1{$_}) {
		print $hash_1{$_}."\n";
	}
	else {
		print "#N/A"."\t"."#N/A"."\n";
	}
}

close W_1;

open (R_5,"< Annotation_all.txt") || die ("Cannot open Annotation_all.txt: $!\n"); # Annotation_all.txt

while ($_=<R_5>) {
	if ($_=~/^(.+?)\t(.+?)\n/) {
		$hash_4{$1}=$2;
	}
}

#select STDOUT;
#while (($key,$value)=each(%hash_4)) {
#	print $key."\t".$value."\n";
#}

$file_list=readpipe("ls ../Step4.Calculating_PL_TO_AAC/Candidate_*.seq.Tab | cat");
#$file_list.="\n";

while ($file_list=~/(.+?)\n/g) {
	$input_file_name=$1;
	if ($input_file_name=~/(Candidate_\d+).seq.Tab/) {
		$candidate_id=$1;
	}
	$output_file_name=$candidate_id.".Annotation.txt";
	open (R_6,"< $input_file_name") || die ("Cannot open $input_file_name: $!\n"); # open Candidate_*.seq.Tab
	open (W_2,"> $output_file_name");
	select W_2;
	print "Gene_ID"."\t"."Protein length (aa)"."\t"."NCBI_nr"."\t"."Pfam"."\t"."InterPro"."\n";
	while ($_=<R_6>) {
		if ($_=~/^(.+?)\t.+?\n/) {
			if (exists($hash_4{$1})) {
				print $1."\t".$hash_4{$1}."\n";
			}
			else {
				print $1."\t"."bug"."\n";
			}
		}
	}
	close R_6;
	close W_2;
}

close R_1;
close R_2;
close R_3;
close R_4;
close R_5;

