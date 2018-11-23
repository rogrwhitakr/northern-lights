#!/usr/bin/env bash

# If null, use default value
FOO=first
echo "The ${FOO-second} choice"
unset $FOO
echo "The ${FOO-second} choice"

# If null or empty, use default value
FOO=first
echo "The ${FOO:-second} choice"
unset $FOO
echo "The ${FOO:-second} choice"

# Default value can be a variable
FOO=first
BAR=second
echo "The ${FOO:-$BAR} choice"
unset $FOO
echo "The ${FOO:-$BAR} choice"