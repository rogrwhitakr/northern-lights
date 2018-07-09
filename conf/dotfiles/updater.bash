#! /usr/bin/env bash

if [[ -f "$(which apt-get)" ]]; then
    echo 'ney'
elif [[ -f "$(which dnf)" ]]; then
    echo 'raiiit'
fi    