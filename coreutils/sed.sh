# bin/sh

NOC='\033[0m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'

################################## 
# date stuff
################################## 

MONTH=25
DATE=`date +%Y-%m-%d`
DISABLE_DATE=`date -d '-6 months ago' +%Y-%m-%d`
_DATE=$(sed -e 's/6 months ago/${MONTH} months ago/g' <<< $DISABLE_DATE)

#_DATE='sed -i "s/6/7/g" $DISABLE_DATE'

echo -e "
${RED}DATE:         $DATE
${YELLOW}DISABLE_DATE: $DISABLE_DATE
${GREEN}_DATE:        $_DATE
${NOC}
"

################################## 
# replacing a \ in a passed variable
################################## 

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

text="this is a text containing\nnewline,\ttab characters,\\ et al....colors:${YELLOW}test${NOC}"
echo "Starting with    :: $text"
echo -e "echo -e\t\t :: $text"

sed -e 's/this/that/g' $text