# /bin/sh
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
awk '$1 ~ /^[0-9]/{$1=""; print $0}' ./history

awk '$1 ~ /^[0-9]/ && $2 = "16:00" {$1=""; print $0}' ./dated_history