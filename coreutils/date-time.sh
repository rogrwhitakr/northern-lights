#! /usr/bin/env bash

RED='\033[0;31m'
NOC='\033[0m' 	


######################################exec

clear

COMMAND="date --utc"
echo -e "${RED}$COMMAND${NOC}"
$COMMAND

args="
	%H		The hour in the HH format (for example, 17).
	%M		The minute in the MM format (for example, 30).
	%S		The second in the SS format (for example, 24).
	%d		The day of the month in the DD format (for example, 16).
	%m		The month in the MM format (for example, 09).
	%Y		The year in the YYYY format (for example, 2013).
	%Z		The time zone abbreviation (for example, CEST).
	%F		The full date in the YYYY-MM-DD format (for example, 2013-09-16). This option is equal to %Y-%m-%d.
	%T		The full time in the HH:MM:SS format (for example, 17:30:24). This option is equal to %H:%M:%S"

COMMAND=date +"%Y-%m-%d"

echo -e '\n' "${RED}"date + format '\n'${NOC} "Formatting = $args"'\n'

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

# subtract two dates
let DIFF=(`date +%s -d 20120203`-`date +%s -d 20120115`)/86400
echo $DIFF

# gnu date 
# seconds since EPOCH
# i assume an intermediate step is necessary
# date -d '-6 months ago' +%Y-%m-%d
echo $(( ($(date --date="2017-05-21 21:18:30" +%s) - $(date --date="2017-05-21 20:28:57" +%s) )/(60*60*24) ))

# example dates taken from journal --list-boots
# Fri 2017-06-09 22:42:01 CEST — Sat 2017-06-10 00:13:14 CEST
# Sat 2017-06-10 08:54:25 CEST — Sun 2017-06-11 19:48:35 CEST
# Thu 2017-06-15 11:07:42 CEST — Mon 2017-06-19 06:23:24 CEST
# Thu 2017-06-22 20:21:43 CEST — Fri 2017-06-23 07:45:54 CEST
# Sat 2017-06-24 00:07:19 CEST — Sun 2017-06-25 20:22:57 CEST
# Fri 2017-06-30 18:55:58 CEST — Mon 2017-07-10 03:48:47 CEST
# Mon 2017-07-10 06:38:56 CEST — Mon 2017-07-10 21:36:43 CEST
# Mon 2017-07-10 21:37:37 CEST — Tue 2017-07-18 20:35:56 CEST

# subtracting or adding elements
startup_datetime="2017-06-10 08:54:25"
shutdown_datetime="2017-06-11 19:48:35"
# subtracting or adding elements
startup_date="2017-06-10"
shutdown_date="2017-06-11"
date --date="${shutdown_date} -${startup_date} day" +%Y-%m-%d
#date --date="${shutdown_datetime} - ${startup_datetime} day" +%Y-%m-%d %h:%M:%s