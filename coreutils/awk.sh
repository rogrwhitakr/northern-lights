# /bin/sh
# AWK

# principal functionality
awk 'program' input-file1 input-file2 …
awk [-F --field-separators] 'program' input-file1 input-file2 …

# get aliases and print 
getent aliases | awk -F: '{ print $1,"||", $5 }'

# print only the GID and UID columns
awk -F: '{print $3,$4}' /etc/passwd

# print last, third, third-to-last field
# use quotes to avoid clashes with shell special characters
echo 'one;2018-02-12;two;CLASH;four;five;nej;2;464;ERROR' | awk -F';' '{print $(NF), "|", $2, "|", $(NF-3)}'

# Regular expressions based input field separator



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

# https://techarena51.com/blog/advance-text-processing-examples-awk/
# https://github.com/learnbyexample/Command-line-text-processing/blob/master/gnu_awk.md