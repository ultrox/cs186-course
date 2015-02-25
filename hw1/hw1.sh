#!/bin/bash
<<<<<<< HEAD
#bash command-line arguments are accessible as $0 (the bash script) $1, etc.
#echo "running" $0 "on" $1

# Fills ebook.csv and tokens.csv files
cat $1 | python hw1.py 

# Puts Headers token,count in token_count.csv in CRLF format
echo -e "token,count\r" > token_counts.csv
echo -e "token,count\r" > name_counts.csv

# Gets second column of token, removes header, and sorts outputing into temptokens.csv file
# Combines common tokens, sorts by decreasing number, turns it into csv style, flips the csv columns, adds the CRLF ending, and finally outputs into token_counts.csv
cat tokens.csv |  cut -d ',' -f2 | tail -n+2 | sort | uniq -c | sort -n -r | awk -v RS="\r\n" '{ print $1 "," $2 }' | awk -F,  '{print $2 "," $1}' | sed $'s/$/\r/'>> token_counts.csv


# Reads popular_names.txt , puts all popular names into lowercase, pattern matches with popular_names.txt
cat popular_names.txt | tr '[:upper:]' '[:lower:]'| grep -iwf ./popular_names.txt ./token_counts.csv >> name_counts.csv

exit 0
=======
# bash command-line arguments are accessible as $0 (the bash script), $1, etc.
# echo "Running" $0 "on" $1
echo "Replace the contents of this file with your solution."
>>>>>>> 17c53cf9e6dac7a277390abfee31b6b10e393f29
