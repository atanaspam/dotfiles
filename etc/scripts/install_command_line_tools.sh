#!/usr/bin/env bash

xcode-select -p 1>/dev/null
if [ $? == 2 ]; then
    echo "Command Line tools missing. Beginning install."
    xcode-select --install
    exit 2
fi
