#!/bin/bash

xcode-select -p 1>/dev/null
if [ $? == 2 ]; then
  echo "Command Line tools missing. Beginning install."
  xcode-select --install
  echo "XCode tools installation started. Please complete the installer, then re-run 'make all'."
  exit 2
fi
