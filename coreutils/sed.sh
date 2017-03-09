# bin/sh
#variables

NOC='\033[0m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'

MONTH=25
DATE=`date +%Y-%m-%d`
DISABLE_DATE=`date -d '-6 months ago' +%Y-%m-%d`
#_DATE='sed -i "s/6/7/g" $DISABLE_DATE'


_DATE=$(sed -e 's/6 months ago/${MONTH} months ago/g' <<< $DISABLE_DATE)

echo -e "

${RED}DATE:         $DATE
${YELLOW}DISABLE_DATE: $DISABLE_DATE
${GREEN}_DATE:        $_DATE
${NOC}
"