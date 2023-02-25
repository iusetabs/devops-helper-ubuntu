#!/bin/bash

# Installs all files in installation-scripts

for file in ./installation-scripts/*.sh; do
    [ -f "$file" ] && [ -x "$file" ] && "$file"
done