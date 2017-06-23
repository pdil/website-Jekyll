#!/bin/bash

# Clone the _site repo so that changes are tracked when the build is pushed back
git clone --quiet "https://${git_token}@${git_target}" > /dev/null 2>&1

# Build site and check HTML for errors
jekyll build
htmlproofer ./_site --alt-ignore '/.*/' --url-ignore '/.*iopscience.iop.org.*/'