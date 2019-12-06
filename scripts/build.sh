#!/bin/bash

# Clone the _site repo so that changes are tracked when the build is pushed back
git clone --quiet "https://${git_token}@${git_target}" > /dev/null 2>&1

# Build site
jekyll build

# Check for HTML errors
htmlproofer ./_site
