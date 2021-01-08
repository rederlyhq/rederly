#!/usr/bin/env bash

# Do not descend into any "node_modules" directories: -type d -name node_modules -prune -false -o
# Do not descend into "source/renderer": -type d -path source/renderer -prune -false -o
# Find package.json files: -type f -name package.json
find source -type d -name node_modules -prune -false -o -type d -path source/renderer -prune -false -o -type f -name package.json