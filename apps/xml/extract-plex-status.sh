#! /bin/bash

set -e

status="$(curl http://192.168.178.65:32400/status/sessions)"

xmlstarlet sel -t -v '//size' "${status}"