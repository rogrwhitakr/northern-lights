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

 read -p "Name a Star Trek character: " CHAR

 case $CHAR in

   "Seven of Nine" | Neelix | Chokotay | Tuvok | Janeway )
       echo "$CHAR was in Star Trek Voyager"
       ;;&

   Archer | Phlox | Tpol | Tucker )
       echo "$CHAR was in Star Trek Enterprise"
       ;;&
   Odo | Sisko | Dax | Worf | Quark )
       echo "$CHAR was in Star Trek Deep Space Nine"
       ;;&
   Worf | Data | Riker | Picard )
       echo "$CHAR was in Star Trek The Next Generation"
       ;;
   *) echo "$CHAR is not in this script." 
       ;;
 esac