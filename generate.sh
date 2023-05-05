awk -F' ' '{print "sed -i '\''s#"$1"#"$2"#g'\'' "$3}' "$1" >sed.sh
#awk -F' ' '{print $1}' software.list
sh sed.sh
echo 'bash ./all_script/prophage_hunter_step1_4' >prophage_hunter_RUN.sh
echo 'bash ./all_script/Step2' >>prophage_hunter_RUN.sh
echo 'bash ./all_script/Step3' >>prophage_hunter_RUN.sh
echo 'bash ./all_script/Step4' >>prophage_hunter_RUN.sh
echo 'bash ./all_script/Step5' >>prophage_hunter_RUN.sh
echo 'bash ./all_script/prophage_hunter_step6' >>prophage_hunter_RUN.sh
echo 'bash ./all_script/prophage_hunter_step7' >>prophage_hunter_RUN.sh
echo 'bash ./all_script/prophage_hunter_step9' >>prophage_hunter_RUN.sh
echo 'wait' >>prophage_hunter_RUN.sh
echo 'bash ./all_script/prophage_hunter_step8' >>prophage_hunter_RUN.sh
chmod 777 prophage_hunter_RUN.sh
