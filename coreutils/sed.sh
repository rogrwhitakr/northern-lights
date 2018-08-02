#! /usr/bin/env bash

# SED

OUTFILE=output.sed.log
INFILE=input.sed.log
echo "heloo" > ${INFILE}
echo "hello" >> ${INFILE}
echo "landy" >> ${INFILE}
echo "lundsu" >> ${INFILE}
echo "world" >> ${INFILE}
echo "docker" >> ${INFILE}
echo "[config demo]
setting_path =	/etc/some/path
setting_flag =	true
#be samba. at least you look guod....
flagg		= yes" >> ${INFILE}

# principal functionality
# replace docker with tocker !
sed -i 's/docker/tocker/g' "${INFILE}"
sed --in-place 's/docker/tocker/g' "${INFILE}"

# replace all occurrences of ‘hello’ to ‘world’ in the file "${INFILE}"
sed 's/hello/world/' "${INFILE}" >${OUTFILE}

# deletion
sed '/hello/d' "${INFILE}"

# edit config values
sed -i -r 's/setting_path =.*/setting_path = \/etc\/modified\/path/' "${INFILE}"
sed -i -r 's/flagg.*=.*/flagg = no, there is an issue with spaces..../' "${INFILE}"
cat "${INFILE}"

exit 0

echo -e "\n\n\n"
sed '/root/p' /etc/passwd

echo -e "\n\n\n"
sed -n '/root/p' /etc/passwd

SRC=/etc/geoclue/geoclue.conf

# print second line
sed -n '1p' ${SRC}


# print lines 1 - 5
sed -n '1,5p' ${SRC}

# replace agent
sed -n -e '/users/,/schmusers/p' ${SRC}

cat $SRC
##################################
# replacing a \ in a passed variable
##################################

rm -f "${INFILE}" "${OUTFILE}"
exit 0

# get functions in file
# could use the declare thing (see .dotfiles/.functions)?
readonly file_with_a_function_declaration="/home/admin/MyScripts/script/helpers/*.sh"

echo 'grep'
grep -h 'init() {' ${file_with_a_function_declaration}
grep -h 'init() {' ${file_with_a_function_declaration} | sed 's/() {//g' >${OUTFILE}

#echo 'sed'
#sed 's/.*\(init()\).*/\1/g' ${file_with_a_function_declaration} >> ${OUTFILE}
# declare -f | grep '^[a-z].* ()' | sed 's/{$//'


has_backslash() {
	if [[ -z "$@" ]]; then
		echo -e "function(): no args set"
		exit
	fi
	#echo -e "$@"
	sedded=$(echo -e "$@" | grep -E '[\]')
	echo -e "$sedded"
}
has_backslash $@

# variable change
SQL="select claim_id from claim;"
SQL=$(sed -e "s/claim/setting/g" <<<$SQL)
echo -e $SQL

# found this on reddit, does some polling of stats?
# anyway it has some sed in it
# maybe take it apart and see what it does
# looks for a digit like 0.0000123 or 312.38487
# seems to be this posix thingy

for i in {1..100}; do
	strace -T -e statfs df . 2>&1
done |
	sed -n '
      # output looks like: statfs(".", {f_foo=BAR, …}) = 0 <0.000241>
      /^.* = <\([[:digit:]]\+\.[[:digit:]]\+\)>$/ {
        s//\1/
        p
      }
    ' |
	sort -n
