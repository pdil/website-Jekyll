#!/bin/bash

set -o errexit -o nounset

if [[ $TRAVIS_BRANCH == 'master' ]] ; then

  rev=$(git rev-parse --short HEAD)
  
  #git clone --quiet "https://${git_token}@${git_target}"
  cd _site
  
  #cd _site
  #git init

  #git config user.name "Paolo Di Lorenzo (Travis CI)"
  #git config user.email "dilorenzopl@gmail.com"

  git add -A .
  git commit -m "Deploy pages at website-generator/${rev}"

  # We redirect any output to
  # /dev/null to hide any sensitive credential data that might otherwise be exposed.
  git push --force --quiet "https://${git_token}@${git_target}" master:master > /dev/null 2>&1
else
  echo 'Invalid branch. You can only deploy from master.'
  exit 1
fi
