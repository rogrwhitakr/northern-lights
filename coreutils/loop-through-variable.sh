# bin/sh
#variables

NOC='\033[0m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'

SQL="select claim_id from claim;"

SQL=$(sed -e "s/claim/setting/g" <<< $SQL)

echo -e "${RED}SQL${NOC}"

VARIABLES=( one two three four )

for VARIABLE in $( VARIABLES[@] ); 
do
	echo -e "$VARIABLE\n"
	sleep 2
done