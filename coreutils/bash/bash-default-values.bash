#!/usr/bin/env bash

# If null, use default value
echo "The ${Null-second} choice"
Null=first
echo "The ${Null-second} choice"

# If null or empty, use default value
echo "The ${NullOrEmpty:-second} choice"
NullOrEmpty=first
echo "The ${NullOrEmpty:-second} choice"

# Default value can be a variable
set_by_variable=third
echo "The ${Default:-$set_by_variable} choice"
Default=second
echo "The ${Default:-$set_by_variable} choice"