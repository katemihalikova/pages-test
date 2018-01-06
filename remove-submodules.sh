#!/usr/bin/env bash

git submodule deinit .
git submodule | cut -c43- | while read -r line; do (git rm "$line"); done
git config --local -l | grep submodule | sed -e 's/^\(submodule\.[^.]*\)\(.*\)/\1/g' | while read -r line; do (git config --local --remove-section "$line"); done
rm .gitmodules
rm -rf .git/modules
