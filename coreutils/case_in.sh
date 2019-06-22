#! /usr/bin/env bash

echo "case explainer"
echo "-----"

read -rp $'Continue (Y/n) : ' -ei $'Y' selection

case "${selection}" in
Y | Ya | yes | Yes)
  echo "you chose ${selection}"
  ;;
N | n | no | "No Way !!!" | Nah | nah)
  echo "You chose ${selection}"
  ;;
*)
  echo "Unexpected expression '${selection}'"
  ;;
esac

# The double semi-colon ‘;;’ will stop attempting to match patterns after the first match is found.
# The semi-colon ampersand ‘;&’ will run the command associated with the next clause. This will happen whether there is a match on the following clause or not.
# The double semi-colon ampersand ‘;;&’ will test the patterns in the rest of the clauses and only execute the command if there is a match.

read -p "Name a Star Trek character: " CHAR

case $CHAR in

"Seven of Nine" | Neelix | Chokotay | Tuvok | Janeway)
  echo "$CHAR was in Star Trek Voyager"
  ;;&

Archer | Phlox | Tpol | Tucker)
  echo "$CHAR was in Star Trek Enterprise"
  ;;&
Odo | Sisko | Dax | Worf | Quark)
  echo "$CHAR was in Star Trek Deep Space Nine"
  ;;&
Worf | Data | Riker | Picard)
  echo "$CHAR was in Star Trek The Next Generation"
  ;;
*)
  echo "$CHAR is not in this script."
  ;;
esac
