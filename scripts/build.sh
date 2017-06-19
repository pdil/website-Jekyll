#!/bin/bash

jekyll build
htmlproofer ./_site --alt-ignore '/.*/' --url-ignore '/.*iopscience.iop.org.*/'