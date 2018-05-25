#! /usr/bin/env bash

# There are three ways to debug:
# 1] Run the script with bash -x:

prompt >>> bash -x ./mybrokenscript

# 2] Modify your script's header:
#!/bin/bash -x
[.. script ..]

# 3] set -x
# Because the debugging output goes to stderr, 
# you will generally see it on the screen, if you are running the script in a terminal. 
# If you would like to log it to a file, you can tell Bash to send all stderr to a file:

exec 2>> $0.log
[..irrelevant code..]
set -x
[..relevant code..]
set +x
[..irrelevant code..]