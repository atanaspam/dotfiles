#!/bin/bash

SCRIPT="$HOME/bin/executable_wifi-toggle.sh"

chmod +x "$SCRIPT"

if launchctl print gui/$(id -u)/nz.haume.wifi-toggle > /dev/null 2>&1; then
  echo "wifi-toggle launchd service already enabled"
else
  "$SCRIPT" on
fi
