#!/usr/bin/env bash
set -euo pipefail

# Setup environment ------------------------------------------------------------

FDAT="/tmp/_batmon" # Stored level from previous run
CRIT=10             # Boundary at which a warning is triggered

# Read the level previously read, otherwise assume we were full
old_lvl=100
if test -f "$FDAT"; then
   old_lvl=`cat $FDAT`
fi

# Get current battery level
new_lvl=$(acpi -b | sed -r 's/.*, ([0-9]+)%.*/\1/')

# NOTE: The sed command extracts: 'any series of consecutive numbers after ", ",
# ignoring everything before and after those numbers'.
#
# This lines up with the output from acpi -b, which is something like:
# >>> acpi -b
# Battery 0: Unknown, 92%, 01:21:23 remaining
#

# Perform computation ----------------------------------------------------------

echo is: $new_lvl was: $old_lvl
if [ $new_lvl -lt $CRIT ] && [ ! $old_lvl -lt $CRIT ]; then
    echo "Battery low: " $new_lvl
    notify-send -u critical "Battery low"
    cvlc --play-and-exit /etc/nixos/assets/sounds/tired.mp3
fi

# Export environment -----------------------------------------------------------

echo $new_lvl > $FDAT
