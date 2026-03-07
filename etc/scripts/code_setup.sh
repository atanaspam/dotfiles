#!/bin/bash

while IFS= read -r EXT; do code --install-extension "$EXT"; done < etc/config/vs_code_extentions
