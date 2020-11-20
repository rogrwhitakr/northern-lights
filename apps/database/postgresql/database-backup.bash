#! /usr/bin/env bash

usage() {
    echo "${0##*/}"
    echo "usage:"
    echo "sudo ${0##*/} -d [optional: backup directory] -f <sql-file>"
    exit 1
}