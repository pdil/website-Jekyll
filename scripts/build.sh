#!/bin/bash

jekyll build
htmlproofer ./_site --alt-ignore '/.*/'