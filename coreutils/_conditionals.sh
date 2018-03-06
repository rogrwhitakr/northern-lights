#! /bin/dash
programme="htop"

if [ "which $programme" = "0" ]; then
    echo "found $programme in $(which $programme)"
else
    echo "nah"
fi