#! bin/sh

RED='\033[0;31m'
NOC='\033[0m' 	


######################################exec

clear

COMMAND="date --utc"
echo -e "${RED}$COMMAND${NOC}"
$COMMAND

args="%H		The hour in the HH format (for example, 17).
	%M		The minute in the MM format (for example, 30).
	%S		The second in the SS format (for example, 24).
	%d		The day of the month in the DD format (for example, 16).
	%m		The month in the MM format (for example, 09).
	%Y		The year in the YYYY format (for example, 2013).
	%Z		The time zone abbreviation (for example, CEST).
	%F		The full date in the YYYY-MM-DD format (for example, 2013-09-16). This option is equal to %Y-%m-%d.
	%T		The full time in the HH:MM:SS format (for example, 17:30:24). This option is equal to %H:%M:%S"

COMMAND=date +"%Y-%m-%d"

echo -e '\n' "${RED}"date + format '\n'${NOC} "Format = $args"'\n'

echo -e "command = $COMMAND"
$COMMAND

DATE=$(date +"%m-%d-%Y")
TIME=$(date +"%h:%m")

echo -e "$DATE\n$TIME"

# there exists the variable HISTTIMEFORMAT
# used by history command 

export HISTTIMEFORMAT='%Y-%m-%d_%H:%M'

MONTH=25
DATE=`date +%Y-%m-%d`
DISABLE_DATE=`date -d '-6 months ago' +%Y-%m-%d`
_DATE=$(sed -e 's/6 months ago/${MONTH} months ago/g' <<< $DISABLE_DATE)

#_DATE='sed -i "s/6/7/g" $DISABLE_DATE'