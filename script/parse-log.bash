#!/bin/bash

source "/home/admin/MyScripts/script/helpers/init.bash"
source "/home/admin/MyScripts/script/helpers/log.bash"

strict=1
debug=1

script_init
flags_init

# workdir is ~/logs

#"/home/admin/logs/rvopt_logs/rvopt_session_"
#stat ~/logs/rvopt_logs/rvopt_session_40/log.txt
awk -F'|' '/Accepted moves per second:/ {print}' /home/admin/logs/rvopt_logs/rvopt_session_16/log.txt

#
#09/14/18 13:55:44 | NOTICE | Non-failed moves per second: 5367
#09/14/18 13:55:44 | NOTICE | Accepted moves per second:   4736
#09/14/18 13:55:44 | NOTICE | Total moves per second:      47318

database_user=opimiser
database_pass=opimiser
database=opimiser
host=192.168.150.180

mysql --host="${host}"\
    --database="${database}"\
    --user="${database_user}"\
    --password="${database_pass}" << EOF
INSERT INTO run (run_name, non_failed_moves, accepted_moves, total_moves)
VALUES ("testrun", 123, 123123, 321);
EOF

mysql -u aurora -paurora