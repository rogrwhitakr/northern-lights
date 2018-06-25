#! /usr/bin/env bash

unit=powerline.service

systemd-analyze verify "${unit}"

if [[ "$?" = 0 ]]; then
    echo -e "okay, seems legit"
    echo -e "continue wit yo thang"
else
    echo -e "aint right, that"
fi     