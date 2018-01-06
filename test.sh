#!/usr/bin/env bash

set -e

git checkout gh-pages

sh ./remove-submodules.sh

GIT_REMOTE=$(git remote get-url origin)

git log master --reverse --oneline --no-color | while read -r line; do
  COMMIT_SHA=$(echo $line | cut -c-7)
  COMMIT_MSG=$(echo $line | cut -c9-)
  echo "Starting $COMMIT_SHA $COMMIT_MSG"

  git submodule add --name $COMMIT_SHA $GIT_REMOTE $COMMIT_SHA

  cd $COMMIT_SHA
  git checkout $COMMIT_SHA
  cd ..

  git add
done

git add .
git commit -m "Refresh submodules"
