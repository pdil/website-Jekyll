#!/bin/bash

set -o errexit -o nounset

if [[ $TRAVIS_BRANCH == 'master' ]] ; then

  rev=$(git rev-parse --short HEAD)
  
  cd _site

  git config user.name "Paolo Di Lorenzo (Travis CI)"
  git config user.email "dilorenzopl@pm.me"

  git add -A .
  git commit -m "Deploy pages at website-generator/${rev}"

  git push --force --quiet "https://${git_token}@${git_target}" master:master > /dev/null 2>&1
else
  echo 'Invalid branch. You can only deploy from master.'
  exit 1
fi
