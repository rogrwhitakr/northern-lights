#! /usr/bin/env bash

# copy the on-failure-static?-unit file to user dir
cp systemd/template-unit-file/on-failure-mail@.service ~/.config/systemd/user/

# copy the psql backup service
cp -f systemd/user-unit-file/psql-* ~/.config/systemd/user/