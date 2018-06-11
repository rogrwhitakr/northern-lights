#! /usr/bin/env bash

read -rp $'Continue (Y/n) : ' -ei $'Y' selection;
echo "selection is $selection"

case "${selection}" in
  a)
    variable=gay
    echo "${variable}"
    ;;
  b)
     b="relative"
    echo "${b}"
    ;;
  *)
    echo "Unexpected expression '${selection}'"
    ;;
esac