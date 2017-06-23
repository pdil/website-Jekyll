#!/bin/bash

# Clone the _site repo so that changes are tracked when the build is pushed back
git clone --quiet "https://${git_token}@${git_target}" master:master > /dev/null 2>&1

git config --global user.name "Paolo Di Lorenzo (Travis CI)"
git config --global user.email "dilorenzopl@gmail.com"

# Build site and check HTML for errors
jekyll build
htmlproofer ./_site --alt-ignore '/.*/' --url-ignore '/.*iopscience.iop.org.*/'
