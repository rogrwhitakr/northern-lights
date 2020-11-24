#! /usr/bin/env bash

# Set magic variables for current file & dir
# this is crude, but works: two down, and then...

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__dir="$(cd "$(dirname "${__dir}")" && pwd)"
source "${__dir}/script/helpers/printer.bash"

print timeline

print green "
arguments:
	%H		The hour in the HH format (for example, 17).
	%M		The minute in the MM format (for example, 30).
	%S		The second in the SS format (for example, 24).
	%d		The day of the month in the DD format (for example, 16).
	%m		The month in the MM format (for example, 09).
	%Y		The year in the YYYY format (for example, 2013).
	%Z		The time zone abbreviation (for example, CEST).
	%F		The full date in the YYYY-MM-DD format (for example, 2013-09-16). This option is equal to %Y-%m-%d.
	%T		The full time in the HH:MM:SS format (for example, 17:30:24). This option is equal to %H:%M:%S"

print timeline

print "date --utc"

_DATE=$(date +"%m-%d-%Y")
_TIME=$(date +"%h:%m")
_DATETIME=$(date +"%Y-%m-%d %H:%M:%S")

print red "${_DATE}"
print red "${_TIME}"
print red "${_DATETIME}"

print timeline

# there exists the variable HISTTIMEFORMAT
# used by history command 
export HISTTIMEFORMAT='%Y-%m-%d_%H:%M'

_MONTH=25
_DATE=`date +%Y-%m-%d`
_DISABLE_DATE=`date -d '-6 months ago' +%Y-%m-%d`
_DATE=$(sed -e 's/6 months ago/${_MONTH} months ago/g' <<< $_DISABLE_DATE)

print yellow "subtract two dates"
let DIFF=(`date +%s -d 20170203`-`date +%s -d 20120115`)/86400
print YELLOW "${DIFF} days difference"

print timeline

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

print timeline
print red "subtracting or adding elements"

startup_datetime="2017-06-10 08:54:25"
shutdown_datetime="2017-07-11 19:48:35"
startup_date="2017-06-10"
shutdown_date="2017-09-15"

print red "startup / shutdown dates"

startup_date=$(date --date="${startup_date}" +%Y-%m-%d)
shutdown_date=$(date --date="${shutdown_date}" "+%Y-%m-%d")

print timeline

# you can leave the formatting out...
date --date="${startup_datetime}" 

# GNU style long options
# what does "@" do? 
date --date="${startup_datetime}" --universal 

# epoch
print timeline
print green "Since EPOCH"
date --date="${startup_datetime}" --universal +%s
date --date="${shutdown_datetime}" --universal +%s

diff="$(($(date --date="${shutdown_datetime}" --universal +%s) - $(date --date="${startup_datetime}" --universal +%s)))"
print green "${diff}"
print yellow "format back from universal to human-readable form"

# no formatting
date -ud@"${diff}"
date -ud@"${diff}" "+%H:%M:%S"
date --universal --date @"${diff}" "+%H:%M:%S"
date --universal --date @"${diff}" "+%M"

print timeline
print yellow "combination of sorts"

date --date=@"$(($(date --date="${startup_datetime}" --universal +%s)-$(date --date="${shutdown_datetime}" --universal +%s)))"
date -ud"$(date --date="${startup_datetime}" "+%Y-%m-%d %H:%M:%S")"
date --date="${shutdown_date}" +%Y-%m-%d
date --date="${shutdown_datetime} - ${startup_datetime} day" +%Y-%m-%d %h:%M:%s

date -ud@"$(date --universal +%s)"
date -ud@"$(date --universal +%s)" + 1468823
date --date="12 hours ago" +%s

print timeline