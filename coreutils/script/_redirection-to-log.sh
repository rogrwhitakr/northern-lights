#! /usr/bin/env bash -

set -o errexit
readonly LOG_FILE="/var/log/script.log"

# Create the destination log file that we can
# inspect later if something goes wrong with the
# initialization.
sudo touch $LOG_FILE

# Make sure that the file is accessible by the user
# that we want to give permissions to read later
# (maybe this script is executed by some other user)
sudo chown $(whoami).$(whoami) $LOG_FILE

# Open standard out at `$LOG_FILE` for write.
# This has the effect 
exec 1>$LOG_FILE

# Redirect standard error to standard out such that 
# standard error ends up going to wherever standard
# out goes (the file).
exec 2>&1

# ls -lah /proc/$(pgrep script.sh)/fd
# https://ops.tips/gists/redirect-all-outputs-of-a-bash-script-to-a-file/