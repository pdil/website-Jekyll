# https://dilorenzo.pl/

[![Build Status](https://travis-ci.org/pdil/website-generator.svg?branch=master)](https://travis-ci.org/pdil/website-generator)

This is my personal github website, which will contain a portfolio of various programming, data analysis, and visualization projects and blog posts. It may also contain personal items such as photographs. Currently it is under construction and will be updated as more repositories are added to the github.

The content on this webpage will be presented in a more accessible and user-friendly manner than the github repositories.

This repository contains the files (e.g. html, layouts, plugins, etc.) used to generate my website using Jekyll. For the generated website files, see [pdil/_site](https://github.com/pdil/_site).

## Build Workflow

Whenever a new commit is pushed to this repository, the website is automatically built and the contents pushed to the [pdil/_site](https://github.com/pdil/_site) repository, where it is hosted by [Github Pages](https://pages.github.com/).

The steps for this process are as follows:

1. Commits to this repository automatically start [Travis CI](https://travis-ci.org/pdil/website-generator) build process.
2. Travis executes `scripts/build.sh`
   * Calls `jekyll build` to generate the website files
   * Calls `html-proofer` to check for HTML errors
3. `jekyll build` creates a `_site` folder with the generated website files.
4. Travis executes `scripts/deploy.sh`
   * `cd`'s into `_site`
   * Creates a git repo (`git init`)
   * Adds all files and commits
   * Pushes to [pdil/_site](https://github.com/pdil/_site)
   * The commit ID of this repo is included in the commit message to [pdil/_site](https://github.com/pdil/_site) so that it's easy to check if the current website-generator commit has been successfully built.
5. When the entire process is complete (or errors out) I am sent a [Pushover](https://pushover.net/) notification indicating the status of the build.

This process makes it very convenient to edit or post to my website while on the go. For example, using the [Working Copy](https://workingcopyapp.com/) iOS app I can edit files and push them to this repository and the website is automatically built and hosted, even though I don't have access to a terminal. It also allows me to receive push notifications on the status of the build.
