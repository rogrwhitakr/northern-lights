#!/usr/bin/env bash
# AWK

# principal functionality
awk 'program' input-file1 input-file2 …
awk [-F --field-separators] 'program' input-file1 input-file2 …

# !!!!! -F --> NO "=", but --> '' for any special characters !!!!
# !!!!! --field-separator=';' --> WITH a "=" !!!!

# get aliases and print 
getent aliases | awk -F: '{ print $1,"||", $5 }'

# print only the GID and UID columns
awk -F: '{print $3,$4}' /etc/passwd

# print last, third, third-to-last field
# use quotes to avoid clashes with shell special characters
echo 'one;2018-02-12;two;CLASH;four;five;nej;2;464;ERROR' | awk -F';' '{print $(NF), "|", $2, "|", $(NF-3)}'

# Regular expressions based input field separator
echo 'Sample123string54with908numbers' | awk -F'[0-9]+' '{print $2}'

# field separator contains "{}=" and a space
echo '{foo}   bar=baz' | awk -F'[{}= ]+' '{print $2}'

# print only the ones containing "systemd"
awk -F: '$1 ~/^systemd/ {print $5}' /etc/passwd

# print using regex
awk -F  '$3 ~/^[0-9]{4,5}/$ {print $1,"|---|",$5}' /etc/passwd

# awk logic / can be added to a file and called as arg -f
awk -F  '{
	for(i=1;i<=NF;i++)
		{ if($i=="/[0-9]{4,5}/")
		{print $i} 
		}
	}' /etc/passwd

# Output Field Separator = OFS 
# gets added between every argument to print statement
# use printf to avoid this -> default is single space!
echo 'one;2018-02-12;two;CLASH;four;five;nej;2;464;ERROR' | awk -v OFS='[]' -F';' '{print $(NF), $(NF), $(NF)}'

# changing a field will re-build contents of $0
echo 'that boi did that bitch' | awk '{$2 = "ninja"; print $0}'
echo 'making som time stamps....' | awk '{ $2 = "some" ; print }'

$ # $1=$1 is an idiomatic way to re-build when there is nothing else to change
echo 'Imma123_do9657dis4wit9283749236486chu' | awk -F'[123456789_]+' '{$1=$1; print $0}'
echo 'Imma123_do9657dis4wit9283749236486chu' | awk -F'[123456789_]+' -v OFS='] [' '{$1=$1; print $0}'

# Regular expressions based filtering
# the REGEXP is specified within // and by default acts upon $0
awk '/dnf/ && /install/' ./history
awk '/dnf/ && !/sudo/' ./history
awk '/^[0-9]{2}/' ./history
awk '/[0-9]{2}+' ./history

# print last field of all lines 
awk '/[0-9]/ {print $NF}' ./history

# REGEXP matching against specific field
awk '$1 ~ /^9/' ./history

# this makes the space explicit
awk -F' ' -v OFS='=' '{ $1=$1 ;print $0 }' ./history

# this matches explicity against the first field
# searches for numbers 0-9
# assigns "" to the first, prints it
history | awk '$1 ~ /^[0-9]/{$1=""; print $0}' ./history

# search all where the first element is between 999 and 1051
# remove the date element ($2) and print the rest  
history | awk '$1 > 999 && $1 < 1051 {$2=""; print $0}'

# unsure what this one does
awk -v RS='#' '{ print}' /<path>/<to>/high-level.txt

# REGEXP Repetition
# (.) -> matches all "fun", "fin", "f3n", "f..."
awk '$0 ~ /f.n/ {print}'

# ^ Find string at beginning of line.
# [+-] Specify possible "+" or "-". 
# "?" --> ONE OCCURENCE
# [0-9]+ Specify digits "0" through "9".
# "+" --> ONE ORE MORE OCCURENCES
# $ Specify that the line ends with the number.
awk '$0 ~ /^[+-]?[0-9]+$ { print }'

# search the first element for number pattern 10-99
# print NUMMER: <NO> | <command>
# -o <outfile the rule>
history | awk -o '$1 ~ /^[0-9]{2}$/ {print "NUMMER:", $1, "|", $NF }'

# first step:
# number the lines using NR in print
echo 'I need to be able to dynamically know how many elements a line has ...' | awk -v RS=' ' '{print NR, $0}'
history | awk '$1 ~ /^2[0-9]{2}$/ {print NR, $3, $NF }'

# dnyamic records
# NR built-in variable contains record number
# RS must be made explicit !!!
# dynamically changing ORS
# ?: ternary operator to select between two expressions based on a condition
# somehow, the "1" at the end needs to be there. do not know why yet
# seq 1 99 does not do it
seq 99 | awk '{ORS = NR%9 ? "-" : "\n"} 1'

awk '{ NR == 1; print NR,$2}' /var/log/boot.log

# awk built in variables
# NR keeps a current count of the number of input records. Records are usually lines; Awk performs the pattern/action statements once for each record in a file.
# NF eeps a count of the number of fields within the current input record. Remember that fields are space-separated words, by default, but they are essentially the "columns" of data if the input file is formatted like a table. The last field of the input line can be accessed with $NF.
# we assign variable lower bound = 1, upper bound = <number of records>

awk '{for (i=1; i<=NF;i++) print "NR (No of records):", NR, "| NF (No of Fields):", i, "| FIELD: <" $i ">"; print "----"}' /var/log/boot.log

# get the boot times
# now i need to diff them
journalctl --list-boots | awk '{ print $4, $7,"||", $5,$8 }'

# addition seems to work
echo "1,2,3" | awk -F',' '{ print $1, $3, $1+$3 }'

# goal -> extract title of site, add to index.html#
# TODOS, then:
# extracting the title
# loop through what is there
# add to index
# probably best done using awk

awk '{print}' /var/www/html/primo-app/index.html
# get current links in index.html
awk '$0 ~ /^<a href=.+/ {print}' /var/www/html/primo-app/index.html

# print all title names usable for linking
awk '$0 ~ /^<title>.+/ {print}' ~/html/*.html

# i dont have the title name yet
awk '$0 ~ /^<title>.+/ && $0 ~ />.+/ { print $1 }' ~/html/*.html

# now i have it
awk -F'[<>]+' '$0 ~ /^<title>.+/ { print $3 }' ~/html/*.html

# i need to put file name and title together
# loop obvi

for file in $(ls -d ~/html/*.html)
do 
  echo $file
  echo $(awk -F'[<>]+' '$0 ~ /^<title>.+/ { print $3 }' $file)
  echo "<a href="$file">$(awk -F'[<>]+' '$0 ~ /^<title>.+/ { print $3 }' $file)</a><br>"
done