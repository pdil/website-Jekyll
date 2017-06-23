#!/bin/bash

# Clone the _site repo so that changes are tracked when the build is pushed back
git clone --quiet "https://${git_token}@${git_target}"

jekyll build
htmlproofer ./_site --alt-ignore '/.*/' --url-ignore '/.*iopscience.iop.org.*/'